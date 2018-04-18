require 'spec_helper'

describe OnTheDotApi::Operations::CreateBooking do
  describe '#execute' do
    before do
      configure_client
    end

    let(:config) { OnTheDotApi::Client.config }
    let(:timeslot_payload_helper) { GetAvailableTimeslotsPayload.new(store_id: config.store_id) }
    let(:booking_payload_helper) { CreateBookingPayload.new(store_id: config.store_id) }

    let(:delivery_date) { "2018-03-14" }

    let(:timeslot_operation_class) { OnTheDotApi::Operations::GetAvailableTimeslots }
    let(:timeslot_response) do
      timeslot_payload = timeslot_payload_helper.payload(
        delivery_date: delivery_date,
        postcode: "HA11JU")
      timeslot_operation_class.new(
        payload: timeslot_payload
      ).execute
    end
    let(:timeslot_id) { timeslot_response["data"]["timeslots"].first["timeslotId"] }
    let(:timeslot_uuid) { timeslot_response["data"]["uuid"] }

    let(:headers) { { "UUID": timeslot_uuid } }

    let(:valid_payload) do
      booking_payload_helper.payload(
        delivery_date: delivery_date,
        timeslot_id: timeslot_id
      )
    end

    context "with valid payload" do
      it "returns valid response" do
        VCR.use_cassette('valid_create_booking_request') do
          response_hash = described_class.new(
            payload: valid_payload,
            headers: headers
          ).execute

          expect(response_hash["success"]).to eq({"status"=>"ok"})
          expect(response_hash["data"]["status"]).to eq("Booked")
        end
      end
    end

    context "with invalid postcode" do
      let(:invalid_payload) do
        booking_payload_helper.payload(
          delivery_date: delivery_date,
          timeslot_id: timeslot_id,
          address_postcode: "111111121111111" # random non-existent postcode
        )
      end

      it "raises 'OnTheDotApi::Errors::ResponseError' exception" do
        VCR.use_cassette('create_booking_request_with_invalid_postcode') do
          expect {
            described_class.new(
              payload: invalid_payload,
              headers: headers
            ).execute
          }.to raise_exception(OnTheDotApi::Errors::ResponseError, "400")
        end
      end
    end

    context "with invalid timeslot id" do
      let(:invalid_payload) do
        booking_payload_helper.payload(
          delivery_date: delivery_date,
          timeslot_id: "1" # random timeslot id
        )
      end

      it "raises 'OnTheDotApi::Errors::ResponseError' exception" do
        VCR.use_cassette('create_booking_request_with_invalid_timeslot_id') do
          expect {
            described_class.new(
              payload: invalid_payload,
              headers: headers
            ).execute
          }.to raise_exception(OnTheDotApi::Errors::ResponseError, "404")
        end
      end
    end

    context "with invalid UUID" do
      it "raises 'OnTheDotApi::Errors::ResponseError' exception" do
        VCR.use_cassette('create_booking_request_with_invalid_uuid') do
          expect {
            described_class.new(
              payload: valid_payload,
              headers: { "UUID": "1111" }
            ).execute
          }.to raise_exception(OnTheDotApi::Errors::ResponseError, "400")
        end
      end
    end
  end
end
