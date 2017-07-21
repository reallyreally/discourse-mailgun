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
      # creating a Hash with header name as key and everything else in an array
      mg_headers = JSON.parse(params['message-headers']).map{|e| [e[0], e[1..-1]]}.to_h
      mg_body    = params['body']
      mg_id      = params['Message-Id']

      m = Mail::Message.new do
        to         mg_headers['To'].first
        from       mg_headers['From'].first
        date       mg_headers['Date'].first
        message_id mg_id
        body       mg_body
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
