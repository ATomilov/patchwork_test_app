module Requests
  class BaseRequest < ::BaseServiceObject
    def call
      response.to_h
    end

    private

    def response
      @response ||= HTTParty.public_send(self.class::REQUEST_METHOD, self.class::TARGET_URL, request_options)
    end

    def request_options
      {
        query: query
      }
    end

    def query
      {
        key: ENV['NOMICS_API_KEY']
      }
    end
  end
end
