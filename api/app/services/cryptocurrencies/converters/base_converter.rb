module Cryptocurrencies
  module Converters
    class BaseConverter < ::BaseServiceObject
      option :source_currency
      option :target_currency
      option :validations, default: lambda {
        [
          ::Cryptocurrencies::Nomics::ConvertCurrenciesContract.new.call(
            source_currency: source_currency,
            target_currency: target_currency
          )
        ]
      }

      def call
        convert_currencies
      end

      private

      include Dry::Monads[:result]

      JOIN_DELIMITER = ', '.freeze

      def convert_currencies
        return Failure(validations_errors) if incoming_data_invalid?
        return Failure(response_object.failure) unless response_object.success?
      end

      def validations_errors
        validations.map do |validation|
          validation.errors(full: true).flat_map(&:text)
        end
      end

      def incoming_data_invalid?
        validations.any?(&:failure?)
      end
    end
  end
end
