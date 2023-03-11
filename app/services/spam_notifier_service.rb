# frozen_string_literal: true

class SpamNotifierService < ApplicationService

  attr_reader :spam_notification


  def self.async_call(spam_notification)
    SpamNotifierServiceJob.perform_async(spam_notification)
  end

  def initialize(spam_notification)
    @spam_notification = spam_notification.with_indifferent_access
  end

  def call
    SlackClient.send_message_async(channel: '#spam', message: message)
  end

  private

  def message
    "Spam notification received From #{spam_notification[:Email]}: #{spam_notification[:Description]} "
  end
end
