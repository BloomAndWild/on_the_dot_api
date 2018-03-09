module OnTheDotApi
  module Operations
    class AmendBooking < Operation
      def http_method
        :put
      end

      def endpoint
        "#{base_url}/v1.0/amendbooking"
      end
    end
  end
end
