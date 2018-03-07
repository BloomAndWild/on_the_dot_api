class CreateBookingPayload
  def initialize(config)
    @config = config
  end

  def payload(options)
    {
      timeslot: {
        timeslotId: options[:timeslot_id]
      },
      webhook: "",
      orderType: "1",
      supplierId: "CitySprint",
      accountNumber: "W99969",
      serviceType: "",
      referenceNo: "",
      departmentReferenceNo: "",
      store: {
        storeId: config[:store_id],
        instruction: "test"
      },
      consumer: {
        name: options.fetch(:customer_name, "test"),
        email: options.fetch(:customer_email, "xyzstore@mail.com"),
        mobileNumber: options.fetch(:customer_mobile_number, "7777777777"),
        address: {
          firstLine: options.fetch(:address_first_line, "House A"),
          secondLine: options.fetch(:address_second_line, "Street B"),
          city: options.fetch(:address_city, "City C"),
          postCode: options.fetch(:address_postcode, "HA11JU")
        },
        instruction: options.fetch(:instructions, "")
      },
      items: {
        item: [
          {
            referenceNumber: "21",
            itemContentCount: 2,
            totalValue: "0",
            weight: 2,
            length: 2,
            width: 2,
            height: 2,
            description: "2 desc"
          }
        ],
        readyAt: "#{options[:delivery_date]}T09:00:00Z"
      },
      notificationType: ""
    };
  end

  private
  attr_reader :config
end
