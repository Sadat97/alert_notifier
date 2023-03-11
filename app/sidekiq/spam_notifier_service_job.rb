class SpamNotifierServiceJob
  include Sidekiq::Job
  sidekiq_options queue: :critical

  def perform(notification_payload)
    SpamNotifierService.call(notification_payload)
  end
end
