module OnTheDotApi
  module Operations
    class CreateBooking < Operation
      def http_method
        :post
      end

      def endpoint
        "#{base_url}/v1.0/booking/"
      end
    end
  end
end
