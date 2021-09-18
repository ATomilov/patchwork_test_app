module RequestsBuilders
  module Cryptocurrencies
    module Nomics
      class GetListRequestBuilder < ::RequestsBuilders::Cryptocurrencies::Nomics::BaseRequestBuilder
        option :currencies_list, []
        option :per_page, optional: true
        option :page_number, optional: true

        def url
          self.class::TARGET_URL
        end

        def request_method
          self.class::REQUEST_METHOD
        end

        private

        TARGET_URL = "#{App.config.api.v1.nomics.base_url}#{App.config.api.v1.nomics.currencies_ticker.path}".freeze
        REQUEST_METHOD = App.config.api.v1.nomics.currencies_ticker.request_method.freeze
        JOIN_DELIMITER = ','.freeze

        def query_params
          super.merge(
            ids: prepared_currencies_list,
            'per-page' => current_per_page,
            page: current_page_number
          )
        end

        def prepared_currencies_list
          currencies_list.join(JOIN_DELIMITER)
        end

        def current_per_page
          per_page.presence || App.config.api.v1.nomics.per_page
        end

        def current_page_number
          page_number.presence || App.config.api.v1.nomics.page_number
        end
      end
    end
  end
end
