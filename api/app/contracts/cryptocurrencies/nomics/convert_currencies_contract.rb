module Cryptocurrencies
  module Nomics
    class ConvertCurrenciesContract < ::Cryptocurrencies::Nomics::BaseContract
      WITHOUT_SPACES_REGEXP = /^\S+$/

      params do
        required(:source_currency).value(:string, format?: WITHOUT_SPACES_REGEXP)
        required(:target_currency).value(:string, format?: WITHOUT_SPACES_REGEXP)
      end
    end
  end
end
