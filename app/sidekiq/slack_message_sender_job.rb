class SlackMessageSenderJob
  include Sidekiq::Job
  sidekiq_options queue: :high

  def perform(channel, message, options = {})
    SlackClient.send_message(channel: channel, message: message, options: options)
  end
end
