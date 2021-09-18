module Cryptocurrencies
  module Nomics
    class GetListContract < ::Cryptocurrencies::Nomics::BaseContract
      ONLY_DIGITS_REGEXP = /^\d+$/.freeze

      params do
        required(:currencies).value(:array).each(:string)
        optional(:per_page).value(:str?, format?: ONLY_DIGITS_REGEXP)
        optional(:page_number).value(:str?, format?: ONLY_DIGITS_REGEXP)
      end

      rule(:per_page) do
        add_allowed_per_page_failure(key: key, value: value)
      end

      rule(:page_number) do
        add_non_positive_failure(key: key, value: value)
      end

      private

      PER_PAGE_ALLOWED_RANGE = (1..ENV.fetch('NOMIC_MAX_PER_PAGE', App.config.api.v1.nomics.per_page)).freeze

      def add_allowed_per_page_failure(key:, value:)
        return if PER_PAGE_ALLOWED_RANGE.cover?(value.to_i)

        key.failure("must be between #{PER_PAGE_ALLOWED_RANGE.first} and #{PER_PAGE_ALLOWED_RANGE.last} (inclusive)")
      end

      def add_non_positive_failure(key:, value:)
        return if value.to_i.positive?

        key.failure('must be positive')
      end
    end
  end
end
