class ApplicationController < ActionController::API
  rescue_from StandardError, with: :handle_standard_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_unprocessable_entity

  private

  def handle_standard_error(error)
    # message = Rails.env.production? ? "Something went wrong." : error.message
    render json: { error: error.message }, status: :internal_server_error
  end

  def handle_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def handle_unprocessable_entity(error)
    render json: { error: error.record.errors.full_messages.to_sentence }, status: :unprocessable_entity
  end
end
