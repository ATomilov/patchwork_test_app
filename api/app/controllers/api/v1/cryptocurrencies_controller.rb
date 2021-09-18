module Api
  module V1
    class CryptocurrenciesController < ::Api::ApiController
      def index
        if list_currencies_validation_result.success?
          responce_object = ::SendRequest.new(request_object: list_currencies_request_object, sender: ::HTTParty).call

          json_response(object: responce_object.success? ? responce_object.value! : responce_object.failure)
        else
          json_response(
            object: validation_errors(validation_result: list_currencies_validation_result),
            status: :bad_request
          )
        end
      end

      private

      JOIN_DELIMITER = ', '.freeze

      def list_currencies_request_object
        @list_currencies_request_object ||= ::RequestsBuilders::Cryptocurrencies::Nomics::GetListRequestBuilder.new(
          currencies_list: params[:currencies]
        )
      end

      def list_currencies_validation_result
        @list_currencies_validation_result ||= ::Cryptocurrencies::Nomics::GetListContract.new.call(
          params.slice(*%i[currencies per_page page_number]).permit!.to_h.compact
        )
      end

      def validation_errors(validation_result:)
        {
          validation_errors: validation_result.errors(full: true).to_h.values.join(JOIN_DELIMITER)
        }
      end
    end
  end
end
