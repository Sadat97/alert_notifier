# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SpamNotifierService, type: :service do
  describe '#call' do
    let(:spam_notification) do
      file_path = Rails.root.join('spec', 'fixtures', 'alerts', 'valid.json')
      JSON.parse(File.read(file_path))
    end

    before do
      allow(SlackClient).to receive(:send_message_async).and_return(true)
    end

    it 'calls the SlackClient' do
      subject = described_class.new(spam_notification)
      expect(SlackClient).to receive(:send_message_async).with(channel: '#spam', message: subject.send(:message))
      subject.call
    end
  end

  describe '#async_call' do
    let(:spam_notification) do
      file_path = Rails.root.join('spec', 'fixtures', 'alerts', 'valid.json')
      JSON.parse(File.read(file_path))
    end

    it 'calls the SpamNotifierServiceJob' do
      expect(SpamNotifierServiceJob).to receive(:perform_async).with(spam_notification)
      described_class.async_call(spam_notification)
    end
  end
end