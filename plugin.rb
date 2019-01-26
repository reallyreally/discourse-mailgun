# name: discourse-mailgun
# about: Discourse Plugin for processing Mailgun webhooks
# version: 0.1
# authors: Gavin Mogan
# url: https://github.com/halkeye/discourse-mailgun

require 'openssl'

enabled_site_setting :mailgun_api_key

after_initialize do
  module ::DiscourseMailgun
    class Engine < ::Rails::Engine
      engine_name "discourse-mailgun"
      isolate_namespace DiscourseMailgun

      class << self
        # signature verification filter
        def verify_signature(timestamp, token, signature, api_key)
          digest = OpenSSL::Digest::SHA256.new
          data = [timestamp, token].join
          hex = OpenSSL::HMAC.hexdigest(digest, api_key, data)

          signature == hex
        end

      end
    end
  end

  require_dependency "application_controller"

  class DiscourseMailgun::MailgunController < ActionController::Base
    before_action :verify_signature

    def incoming
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

      Jobs.enqueue(:process_email, mail: m.to_s, retry_on_rate_limit: true)

      render plain: "done"
    end

    # we mark this controller as an API
    # in order to skip CSRF and other discourse filters
    def is_api?
      true
    end

    private

    def verify_signature
      unless ::DiscourseMailgun::Engine.verify_signature(params['timestamp'], params['token'], params['signature'], SiteSetting.mailgun_api_key)
        render json: {}, :status => :unauthorized
      end
    end
  end


  DiscourseMailgun::Engine.routes.draw do
    post "/incoming" => "mailgun#incoming"
  end

  Discourse::Application.routes.append do
    mount ::DiscourseMailgun::Engine, at: "mailgun"
  end
end
