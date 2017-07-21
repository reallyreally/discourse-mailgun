# name: discourse-mailgun
# about: Discourse Plugin for processing Mailgun webhooks
# version: 0.1
# authors: Tiago Macedo
# url: https://github.com/reallyreally/discourse-mailgun

require 'openssl'

after_initialize do

  module ::DiscourseMailgun
    class Engine < ::Rails::Engine
      engine_name "discourse-mailgun"
      isolate_namespace DiscourseMailgun
    end
  end

  require_dependency "application_controller"

  class DiscourseMailgun::MailgunController < ::ApplicationController
    before_filter :verify_signature

    def webhook
      mg_body    = params['body-plain']
      mg_subj    = params['subject']
      mg_to      = params['To']
      mg_from    = params['From']
      mg_date    = params['Date']

      m = Mail::Message.new do
        to      mg_to
        from    mg_from
        date    mg_date
        subject mg_subj
        body    mg_body
      end

      raw_email = m.to_s

      render json: "done"
    end

    # we mark this controller as an API
    # in order to skip CSRF and other discourse filters
    def is_api?
      true
    end

    private 

    # signature verification filter
    def verify_signature
      digest = OpenSSL::Digest::SHA256.new
      data = [params['timestamp'], params['token']].join
      hex = OpenSSL::HMAC.hexdigest(digest, SiteSetting.mailgun_api_key, data)

      render json: {}, :status => :unauthorized unless params['signature'] == hex
    end
  end


  DiscourseMailgun::Engine.routes.draw do
    post "/webhook" => "mailgun#webhook"
  end

  Discourse::Application.routes.append do
    mount ::DiscourseMailgun::Engine, at: "mailgun"
  end
end
