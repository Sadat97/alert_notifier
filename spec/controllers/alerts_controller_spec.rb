# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AlertsController, type: :controller do
  describe 'POST #create' do
    context 'when the payload is valid' do
      let(:alert_valid_payload) do
        file_path = Rails.root.join('spec', 'fixtures', 'alerts', 'valid.json')
        JSON.parse(File.read(file_path))
      end

      it 'returns http success' do
        post :create, params: alert_valid_payload
        expect(response).to have_http_status(:success)
      end

      it 'calls the AlertHandlerService' do
        expect_any_instance_of(AlertHandlerService).to receive(:call)
        post :create, params: alert_valid_payload
      end
    end


    context 'when the payload is invalid' do
      let(:alert_invalid_payload) do
        file_path = Rails.root.join('spec', 'fixtures', 'alerts', 'invalid.json')
        JSON.parse(File.read(file_path))
      end

      it 'returns http unprocessable_entity' do
        post :create, params: alert_invalid_payload
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'calls the AlertHandlerService' do
        expect_any_instance_of(AlertHandlerService).to receive(:call)
        post :create, params: alert_invalid_payload
      end
    end
  end
end
