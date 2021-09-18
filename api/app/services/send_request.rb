class SendRequest < ::BaseServiceObject
  option :request_object
  option :sender

  def call
    handle_response
  end

  private

  include Dry::Monads[:result]

  def handle_response
    response.success? ? Success(response.parsed_response) : Failure(response.to_s)
  rescue Timeout::Error,
         OpenSSL::SSL::SSLError,
         Errno::ECONNRESET,
         NoMethodError,
         Net::HTTPBadResponse => e
    Failure(e.message)
  end

  def response
    @response ||= sender.public_send(
      request_object.request_method,
      request_object.url,
      request_object.options
    )
  end
end
