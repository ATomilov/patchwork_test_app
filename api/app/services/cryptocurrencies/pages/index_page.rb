module Cryptocurrencies
  module Pages
    class IndexPage < ::BaseServiceObject
      option :currencies
      option :per_page, optional: true
      option :page_number, optional: true
      option :display_fields, optional: true
      option :broker_currency, optional: true
      option :validations, default: lambda {
        [
          ::Cryptocurrencies::Nomics::GetListContract.new.call(
            self.class.dry_initializer.public_attributes(self).except(:validations).compact
          )
        ]
      }

      def call
        show_currencies
      end

      private

      include Dry::Monads[:result]

      def show_currencies
        return Failure(validations_errors) if incoming_data_invalid?
        return Failure(response_object.failure) unless response_object.success?

        Success(
          ::ObjectFilterers::Hashes::SliceKeys.in_array_of_hashes(
            array: response_object.value!,
            keys: display_fields
          )
        )
      end

      def validations_errors
        validations.map do |validation|
          validation.errors(full: true).flat_map(&:text)
        end
      end

      def incoming_data_invalid?
        validations.any?(&:failure?)
      end

      def response_object
        @response_object ||= ::SendRequest.new(
          request_object: request_object,
          sender: ::HTTParty
        ).call
      end

      def request_object
        ::RequestsBuilders::Cryptocurrencies::Nomics::GetListRequestBuilder.new(
          **self.class.dry_initializer.public_attributes(self).except(:validations).compact
        )
      end
    end
  end
end
