require 'spec_helper'

describe OnTheDotApi::Operations::CancelBooking do
  describe '#execute' do
    before do
      configure_client
    end

    let(:config) { OnTheDotApi::Client.config }

    let(:timeslot_payload_helper) { GetAvailableTimeslotsPayload.new(store_id: config.store_id) }
    let(:create_booking_payload_helper) { CreateBookingPayload.new(store_id: config.store_id) }

    let(:delivery_date) { "2018-03-14" }

    let(:timeslot_operation_class) { OnTheDotApi::Operations::GetAvailableTimeslots }
    let(:create_booking_operation_class) { OnTheDotApi::Operations::CreateBooking }

    let(:booking_response) do
      timeslot_payload = timeslot_payload_helper.payload(
        delivery_date: delivery_date,
        postcode: "HA11JU")
      timeslot_response = timeslot_operation_class.new(payload: timeslot_payload).execute
      timeslot_id = timeslot_response["data"]["timeslots"].first["timeslotId"]
      timeslot_uuid = timeslot_response["data"]["uuid"]

      booking_payload = create_booking_payload_helper.payload(
        delivery_date: delivery_date,
        timeslot_id: timeslot_id
      )

      booking_response = create_booking_operation_class.new(
        payload: booking_payload,
        headers: { "UUID": timeslot_uuid }
      ).execute
    end

    context "with valid payload" do
      it "cancels booking" do
        VCR.use_cassette('valid_cancel_booking_request') do
          response_hash = described_class.new(
            order_number: booking_response["data"]["orderNo"]
          ).execute

          expect(response_hash["success"]).to eq({"status"=>"ok"})
        end
      end
    end

    context "with random booking id" do
      it "raises 'OnTheDotApi::Errors::ResponseError' exception" do
        VCR.use_cassette('cancel_booking_request_with_invalid_booking_id') do
          expect {
            described_class.new(order_number: "abc").execute
          }.to raise_exception(OnTheDotApi::Errors::ResponseError, "404 Not Found")
        end
      end
    end
  end
end
