module RequestsBuilders
  module Cryptocurrencies
    module Nomics
      class BaseRequestBuilder < ::RequestsBuilders::BaseRequestBuilder
        private

        def build_options
          {
            query: query_params
          }
        end

        def query_params
          {
            key: ENV['NOMICS_API_KEY']
          }
        end
      end
    end
  end
end
