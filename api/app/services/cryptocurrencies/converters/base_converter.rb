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
        raise NotImplementedError
      end

      def formatted_validation_result_string
        validations.map do |validation|
          validation.errors(full: true).flat_map(&:text)
        end.join(JOIN_DELIMITER)
      end

      def incoming_data_invalid?
        validations.any?(&:failure?)
      end
    end
  end
end
