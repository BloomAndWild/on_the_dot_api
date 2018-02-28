module OnTheDotApi
  module Errors
    class ResponseError < StandardError
      attr_accessor :code, :payload, :http_body, :response

      def initialize(args)
        @code = args[:code]
        @payload = args[:payload]
        @http_body = args[:http_body]
        @response = args[:response]

        super(args[:message])
      end
    end
  end
end
