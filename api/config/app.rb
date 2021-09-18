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
      end
    end
  end
end
