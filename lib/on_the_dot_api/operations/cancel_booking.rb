module OnTheDotApi
  module Operations
    class CancelBooking < Operation
      def http_method
        :delete
      end

      def endpoint
        "#{base_url}/v1.0/cancelbooking/#{store_id}/#{options[:order_number]}/"
      end
    end
  end
end
