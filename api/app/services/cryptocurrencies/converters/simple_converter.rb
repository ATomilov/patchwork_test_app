module Cryptocurrencies
  module Converters
    class SimpleConverter < ::Cryptocurrencies::Converters::BaseConverter
      private

      def convert_currencies
        super

        Success(rate: response_object.value!.first&.fetch('price', 0).to_f)
      end

      def response_object
        @response_object ||= ::SendRequest.new(
          request_object: request_object,
          sender: ::HTTParty
        ).call
      end

      def request_object
        ::RequestsBuilders::Cryptocurrencies::Nomics::ConvertCurrenciesRequestBuilder.new(
          source_currency: source_currency,
          target_currency: target_currency
        )
      end
    end
  end
end
