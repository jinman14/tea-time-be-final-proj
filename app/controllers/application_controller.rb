class ApplicationController < ActionController::API
  rescue_from StandardError, with: :handle_standard_error

  private

  def handle_standard_error(error)
    # message = Rails.env.production? ? "Something went wrong." : error.message
    render json: { error: error.message }, status: :bad_request
  end
end
