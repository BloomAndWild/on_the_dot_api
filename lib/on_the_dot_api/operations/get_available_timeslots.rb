module OnTheDotApi
  module Operations
    class GetAvailableTimeslots < Operation
      def http_method
        :post
      end

      def endpoint
        "#{base_url}/v1.0/timeslotsV2/"
      end
    end
  end
end
