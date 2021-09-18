class App
  extend Dry::Configurable

  setting :api do
    setting :v1 do
      setting :nomics do
        setting :base_url, default: 'https://api.nomics.com/v1/'
        setting :currencies_ticker do
          setting :path, default: 'currencies/ticker'
          setting :request_method, default: 'get'
        end
        setting :per_page, default: 100
        setting :page_number, default: 1
        setting :broker_currency, default: 'USD'
        setting :errors do
          setting :missing_currencies,
                  default: 'Some currencies are missing in the response of an external API service'
        end
      end
    end
  end
end
