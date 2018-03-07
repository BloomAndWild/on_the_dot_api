class GetAvailableTimeslotsPayload
  def initialize(config)
    @config = config
  end

  def payload(options)
    {
      consumer: {
        address: {
          postCode: options.fetch(:postcode, "SE11 5QY")
        }
      },
      items: {
        readyAt: "#{options[:delivery_date]}T09:00:00Z",
        deliveryDates: [
          {
            deliveryDate: options[:delivery_date],
            openTime: options.fetch(:open_time, "09:00"),
            closeTime: options.fetch(:close_time, "18:00")
          },
        ],
      },
      store: {
        storeId: config[:store_id],
        timeslotDuration: 2
      }
    }
  end

  private
  attr_reader :config
end
