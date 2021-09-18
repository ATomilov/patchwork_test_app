module Api
  class ApiController < ActionController::API
    # rescue_from Exception, with: :exception_handler

    private

    EXCEPTIONS = {
      'ActiveRecord::RecordNotFound' => 404,
      'ActionController::ParameterMissing' => 400,
      'ActiveRecord::RecordInvalid' => 422,
      'ArgumentError' => 400
    }.freeze

    def exception_handler(exception)
      json_response(object: { errors: [exception.message] }, status: EXCEPTIONS[exception.class.to_s] || 500)
    end

    def json_response(object:, status: :ok)
      render json: object, status: status
    end
  end
end
