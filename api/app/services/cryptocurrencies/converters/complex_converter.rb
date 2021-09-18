module Cryptocurrencies
  module Converters
    class ComplexConverter < ::Cryptocurrencies::Converters::BaseConverter
      option :broker_currency, optional: true

      private

      include ::Constants

      MISSING_CURRENCIES_ERROR = App.config.api.v1.nomics.errors.missing_currencies.freeze
      ATTRIBUTES_SELECT = %w[id price].freeze

      def convert_currencies
        super

        response_object_value = response_object.value!
        return Failure(MISSING_CURRENCIES_ERROR) if response_object_value.size < 2

        Success(rate: calculate_rate(response_object_value))
      end

      def calculate_rate(response)
        prices_hash = response.pluck(*ATTRIBUTES_SELECT).to_h.transform_values(&:to_f)

        1 / (prices_hash[source_currency] / prices_hash[target_currency])
      end

      def response_object
        @response_object ||= ::SendRequest.new(
          request_object: request_object,
          sender: ::HTTParty
        ).call
      end

      def request_object
        ::RequestsBuilders::Cryptocurrencies::Nomics::GetListRequestBuilder.new(
          currencies_list: [source_currency, target_currency],
          broker_currency: broker_currency.presence || DEFAULT_BROKER_CURRENCY
        )
      end
    end
  end
end
