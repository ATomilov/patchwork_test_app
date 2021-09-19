module Api
  module V1
    class CryptocurrenciesController < ::Api::ApiController
      def index
        render_monads_result(
          monads_result: ::Cryptocurrencies::Pages::IndexPage.new(
            **params.slice(*%i[currencies per_page page_number display_fields broker_currency]).permit!.to_h
          ).call
        )
      end

      def convert_currencies
        render_monads_result(
          monads_result: ::Cryptocurrencies::Converters::SimpleConverter.new(
            **params.slice(*%i[source_currency target_currency]).permit!.to_h
          ).call
        )
      end

      def convert_currencies_via_additional_currency
        render_monads_result(
          monads_result: ::Cryptocurrencies::Converters::ComplexConverter.new(
            **params.slice(*%i[source_currency target_currency broker_currency]).permit!.to_h
          ).call
        )
      end

      private

      def render_monads_result(monads_result:)
        json_response(
          object: monads_result.success? ? monads_result.value! : { errors: Array.wrap(monads_result.failure) }
        )
      end
    end
  end
end
