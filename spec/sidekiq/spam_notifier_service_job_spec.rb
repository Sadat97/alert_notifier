# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SpamNotifierServiceJob, type: :job do
    it { is_expected.to be_processed_in :critical }

    describe '#perform' do
      before do
        allow(SpamNotifierService).to receive(:call).and_return(true)
      end

      let(:spam_notification) do
        file_path = Rails.root.join('spec', 'fixtures', 'alerts', 'valid.json')
        JSON.parse(File.read(file_path))
      end

      it 'calls the SpamNotifierService' do
        expect(SpamNotifierService).to receive(:call).with(spam_notification)
        described_class.new.perform(spam_notification)
      end
    end
end
