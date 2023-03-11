# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AlertHandlerService, type: :service do
  describe '#call' do
    before do
      allow(SpamNotifierService).to receive(:async_call).and_return(true)
    end

    context 'when the payload is valid' do

      let(:alert_valid_payload) do
        file_path = Rails.root.join('spec', 'fixtures', 'alerts', 'valid.json')
        JSON.parse(File.read(file_path))
      end

      it 'returns true' do
        service = described_class.new(alert_valid_payload)
        expect(service.call).to eq(true)
      end

      it 'calls the spam notifier service' do
        expect(SpamNotifierService).to receive(:async_call)
        service = described_class.new(alert_valid_payload)
        service.call
      end
    end

    context 'when the payload is invalid' do

      let(:alert_invalid_payload) do
        file_path = Rails.root.join('spec', 'fixtures', 'alerts', 'invalid.json')
        JSON.parse(File.read(file_path))
      end

      it 'returns false' do
        service = described_class.new(alert_invalid_payload)
        expect(service.call).to eq(false)
      end

      it 'does not call the spam notifier service' do
        expect(SpamNotifierService).not_to receive(:async_call)
        service = described_class.new(alert_invalid_payload)
        service.call
      end

      it 'returns the errors' do
        service = described_class.new(alert_invalid_payload)
        service.call
        expect(service.errors[:alert]).to be_present
        expect(service.errors[:alert]).to include("type unknown: #{alert_invalid_payload['Type']}")
      end
    end
  end
end