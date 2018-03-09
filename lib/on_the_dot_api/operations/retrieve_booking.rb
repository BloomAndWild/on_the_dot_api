module OnTheDotApi
  module Operations
    class RetrieveBooking < Operation
      def http_method
        :get
      end

      def endpoint
        "#{base_url}/v1.0/bookings/orderid/#{store_id}/#{options[:order_number]}/"
      end
    end
  end
end
