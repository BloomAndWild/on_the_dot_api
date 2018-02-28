module OnTheDotApi
  class Operation
    def initialize(payload)
      @payload = payload
    end

    def config
      Client.config
    end

    def headers
      {
        "Channel" => "ECOM",
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json"
      }
    end

    def execute
      begin
        response = RestClient::Request.execute(
          method: http_method,
          url: endpoint,
          payload: payload.to_json,
          headers: headers
        )
        JSON.parse(response.body)
      rescue RestClient::ExceptionWithResponse => e
        raise OnTheDotApi::Errors::ResponseError.new(
          payload: payload.inspect,
          code: e.http_code,
          http_body: e.http_body,
          response: e.response.inspect,
          message: e.message
        )
      end
    end

    private
    attr_reader :payload

    def base_url
      config.base_url
    end

    def api_key
      config.api_key
    end

    def store_id
      config.store_id
    end
  end
end
