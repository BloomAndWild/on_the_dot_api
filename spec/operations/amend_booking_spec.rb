require 'spec_helper'

describe OnTheDotApi::Operations::AmendBooking do
  describe '#execute' do
    before do
      configure_client
    end

    let(:config) { OnTheDotApi::Client.config }

    let(:timeslot_payload_helper) { GetAvailableTimeslotsPayload.new(store_id: config.store_id) }
    let(:create_booking_payload_helper) { CreateBookingPayload.new(store_id: config.store_id) }
    let(:amend_booking_payload_helper) { AmendBookingPayload.new(store_id: config.store_id) }

    let(:delivery_date) { "2018-03-14" }

    let(:timeslot_operation_class) { OnTheDotApi::Operations::GetAvailableTimeslots }
    let(:create_booking_operation_class) { OnTheDotApi::Operations::CreateBooking }

    let(:timeslot_response) do
      timeslot_payload = timeslot_payload_helper.payload(
        delivery_date: delivery_date,
        postcode: "HA11JU")
      timeslot_response = timeslot_operation_class.new(payload: timeslot_payload).execute
    end

    let(:timeslot_id) { timeslot_response["data"]["timeslots"].first["timeslotId"] }
    let(:timeslot_uuid) { timeslot_response["data"]["uuid"] }

    let(:booking_response) do
      booking_payload = create_booking_payload_helper.payload(
        delivery_date: delivery_date,
        timeslot_id: timeslot_id,
        address_first_line: "House A"
      )

      booking_response = create_booking_operation_class.new(
        payload: booking_payload,
        headers: { "UUID": timeslot_uuid }
      ).execute
    end

    let(:updated_booking_payload) do
      amend_booking_payload_helper.payload(
        delivery_date: delivery_date,
        timeslot_id: timeslot_id,
        address_first_line: "House B",
        order_number: booking_response["data"]["orderNo"]
      )
    end

    context "with valid payload" do
      it "amends booking" do
        VCR.use_cassette('valid_amend_booking_request') do
          expect(booking_response["data"]["consumer"]["address"]["firstLine"]).to eq("House A")

          response_hash = described_class.new(
            payload: updated_booking_payload,
            headers: { "UUID": timeslot_uuid }
          ).execute

          expect(response_hash["success"]).to eq({"status"=>"ok"})
          expect(response_hash["data"]["consumer"]["address"]["firstLine"]).to eq("House B")
        end
      end
    end
  end
end
