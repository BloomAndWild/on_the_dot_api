module OnTheDotApi
  module Operations
    class GettAllBookings < Operation
      def http_method
        :get
      end

      def endpoint
        "#{base_url}/v1.0/bookings/storeid/#{store_id}/"
      end
    end
  end
end
