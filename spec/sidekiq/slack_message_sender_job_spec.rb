# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SlackMessageSenderJob, type: :job do
  it { is_expected.to be_processed_in :high }


  describe '#perform' do
    before do
      allow(SlackClient).to receive(:send_message).and_return(true)
    end

    let(:channel) { '#test' }
    let(:message) { 'test message' }
    let(:options) { { as_user: true } }

    it 'calls the SlackClient' do
      expect(SlackClient).to receive(:send_message).with(channel: channel, message: message, options: options)
      described_class.new.perform(channel, message, options)
    end
  end
end

