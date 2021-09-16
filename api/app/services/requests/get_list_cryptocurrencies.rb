module Requests
  class GetListCryptocurrencies < ::Requests::BaseRequest
    option :currencies_list, []

    private

    TARGET_URL = "#{ENV['NOMICS_API_BASE_URL']}#{App.config.api.v1.currencies_ticker.path}".freeze
    REQUEST_METHOD = App.config.api.v1.currencies_ticker.request_method.freeze
    JOIN_DELIMITER = ', '.freeze

    def query
      super.merge(ids: currencies_list.join(JOIN_DELIMITER))
    end
  end
end
