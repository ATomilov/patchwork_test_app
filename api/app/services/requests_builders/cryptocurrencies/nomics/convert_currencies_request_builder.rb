# frozen_string_literal: true

module RequestsBuilders
  module Cryptocurrencies
    module Nomics
      class ConvertCurrenciesRequestBuilder < ::RequestsBuilders::Cryptocurrencies::Nomics::BaseRequestBuilder
        option :source_currency
        option :target_currency

        def url
          self.class::TARGET_URL
        end

        def request_method
          self.class::REQUEST_METHOD
        end

        private

        TARGET_URL = "#{App.config.api.v1.nomics.base_url}#{App.config.api.v1.nomics.currencies_ticker.path}".freeze
        REQUEST_METHOD = App.config.api.v1.nomics.currencies_ticker.request_method.freeze

        def query_params
          super.merge(
            ids: source_currency,
            convert: target_currency
          )
        end
      end
    end
  end
end
