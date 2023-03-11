# frozen_string_literal: true

class AlertHandlerService < ApplicationService

  attr_reader :alert

  include ActiveModel::Validations

  def initialize(alert_payload)
    @alert = alert_payload.with_indifferent_access
  end

  def call
    case alert[:Type]
    when 'SpamNotification'
      handle_spam_notification
    else
      errors.add :alert, "type unknown: #{alert[:Type]}"
    end

    errors.empty?
  end

  private

  def handle_spam_notification
    SpamNotifierService.async_call(alert)
  end
end
