# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SlackClient, type: :service do
  before do
    allow_any_instance_of(Slack::Web::Client).to receive(:auth_test).and_return(true)
    allow_any_instance_of(Slack::Web::Client).to receive(:chat_postMessage).and_return(true)
  end

  describe '#send_message_async' do
    let(:channel) { '#test' }
    let(:message) { 'test message' }
    let(:options) { { as_user: true } }

    it 'calls the SlackMessageSenderJob' do
      expect(SlackMessageSenderJob).to receive(:perform_async).with(channel, message, options)
      described_class.send_message_async(channel: channel, message: message, options: options)
    end
  end

  describe '#send_message' do
    let(:channel) { '#test' }
    let(:message) { 'test message' }
    let(:options) { { as_user: true } }

    it 'calls the SlackClient' do
      expect_any_instance_of(Slack::Web::Client).to receive(:chat_postMessage).with(channel: channel, text: message, as_user: true)
      described_class.send_message(channel: channel, message: message, options: options)
    end
  end
end

