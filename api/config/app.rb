class App
  extend Dry::Configurable

  # rubocop:disable Metrics/BlockLength
  setting :api do
    setting :v1 do
      setting :currencies_ticker do
        setting :path, default: 'currencies/ticker'
        setting :request_method, default: 'get'
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
