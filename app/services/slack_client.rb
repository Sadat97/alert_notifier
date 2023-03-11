# frozen_string_literal: true

class SlackClient < ApplicationService

  class << self
    def send_message_async(channel:, message:, options: {})
      SlackMessageSenderJob.perform_async(channel, message, options)
    end

    def send_message(**args)
      new.send_message(**args)
    end

  end

  attr_reader :client

  def initialize
    @client = Slack::Web::Client.new
  end

  def test_auth
    client.auth_test
  end

  def send_message(channel:, message:, options: {})
    client.chat_postMessage(
      channel: channel,
      text: message,
      **options
    )
  end

end
