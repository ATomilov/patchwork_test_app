module Api
  module V1
    class CryptocurrenciesController < ::Api::ApiController
      def index
        if list_currencies_validation_result.success?
          responce_object = ::SendRequest.new(request_object: list_currencies_request_object, sender: ::HTTParty).call
          if responce_object.success?
            json_response(
              object: prepared_array_of_hashes(
                array: responce_object.value!,
                keys: params[:display_fields]
              )
            )
          else
            json_response(object: responce_object.failure)
          end
        else
          json_response(
            object: validation_errors(validation_result: list_currencies_validation_result),
            status: :bad_request
          )
        end
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

      JOIN_DELIMITER = ', '.freeze
      FIELDS_TO_VALIDATE = %i[currencies per_page page_number display_fields broker_currency].freeze

      def render_monads_result(monads_result:)
        json_response(
          object: monads_result.success? ? monads_result.value! : { errors: Array.wrap(monads_result.failure) }
        )
      end

      def prepared_array_of_hashes(array:, keys:)
        ::ObjectFilterers::Hashes::SliceKeys.in_array_of_hashes(array: array, keys: keys)
      end

      def validation_errors(validation_result:)
        {
          validation_errors: validation_result.errors(full: true).to_h.values.join(JOIN_DELIMITER)
        }
      end

      def list_currencies_request_object
        @list_currencies_request_object ||= ::RequestsBuilders::Cryptocurrencies::Nomics::GetListRequestBuilder.new(
          currencies_list: params[:currencies]
        )
      end

      def list_currencies_validation_result
        @list_currencies_validation_result ||= ::Cryptocurrencies::Nomics::GetListContract.new.call(
          params.slice(*FIELDS_TO_VALIDATE).permit!.to_h
        )
      end
    end
  end
end
