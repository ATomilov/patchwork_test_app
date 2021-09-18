module RequestsBuilders
  class BaseRequestBuilder < ::BaseServiceObject
    def url
      raise NotImplementedError
    end

    def request_method
      raise NotImplementedError
    end

    def options
      build_options
    end

    private

    def build_options
      raise NotImplementedError
    end
  end
end
