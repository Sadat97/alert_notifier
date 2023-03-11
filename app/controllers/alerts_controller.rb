class AlertsController < ApplicationController

  # POST /alerts
  def create
    service = AlertHandlerService.new(alert_params.to_h)

    if service.call
      render json: service.alert, status: :created
    else
      render json: { errors: service.errors.details }, status: :unprocessable_entity
    end

  end

  # Only allow a list of trusted parameters through.
  def alert_params
    params.permit(:RecordType, :Type, :TypeCode, :Name, :Tag, :MessageStream, :Description, :Email, :From, :BouncedAt)
  end
end
