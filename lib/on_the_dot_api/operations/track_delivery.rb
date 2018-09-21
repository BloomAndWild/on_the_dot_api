module OnTheDotApi
  module Operations
    class TrackDelivery < Operation
      def http_method
        :get
      end

      def endpoint
        "#{base_url}/v1.0/track/store/#{store_id}/job/#{options[:order_number]}"
      end
    end
  end
end
