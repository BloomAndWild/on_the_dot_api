module OnTheDotApi
  class Operation
    def initialize(options = {})
      @options = options
    end

    def config
      Client.config
    end

    def payload
      options.fetch(:payload, {})
    end

    def params
      options.fetch(:params, {})
    end

    def body
      payload.to_json if payload.any?
    end

    def headers
      {
        "Channel" => "ECOM",
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json"
      }.merge(options.fetch(:headers, {}))
    end

    def execute
      conn = Faraday.new
      conn.headers = headers
      conn.params = params if params.any?
      conn.use Faraday::Response::Logger, config.logger, bodies: true
      response = conn.public_send(http_method, endpoint, body)
      if response.success?
        JSON.parse(response.body)
      else
        raise OnTheDotApi::Errors::ResponseError.new(
          payload: payload.inspect,
          code: response.status,
          http_body: response.body,
          response: response.inspect,
          message: "#{response.status}"
        )
      end
    end

    private
    attr_reader :options

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
