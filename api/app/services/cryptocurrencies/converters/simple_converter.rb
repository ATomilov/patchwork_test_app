module Cryptocurrencies
  module Converters
    class SimpleConverter < ::BaseServiceObject
      option :source_currency
      option :target_currency
      option :validator, default: -> { ::Cryptocurrencies::Nomics::ConvertCurrenciesContract.new }

      def call
        convert_currencies
      end

      private

      include Dry::Monads[:result]

      JOIN_DELIMITER = ', '.freeze

      def convert_currencies
        return Failure(validation_error) unless validation_result.success?
        return Failure(response_object.failure) unless response_object.success?

        Success(rate: response_object.value!.first&.fetch('price', 0).to_f)
      end

      def failure_result(error_string:)
        Failure(error_string: error_string)
      end

      def validation_error
        validation_result.errors(full: true).to_h.values.join(JOIN_DELIMITER)
      end

      def validation_result
        @validation_result ||= validator.call(
          source_currency: source_currency,
          target_currency: target_currency
        )
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
