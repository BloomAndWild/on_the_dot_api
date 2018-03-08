require 'spec_helper'

describe OnTheDotApi::Operations::GetAvailableTimeslots do
  describe '#execute' do
    before do
      configure_client
    end

    let(:config) { OnTheDotApi::Client.config }
    let(:payload_helper) { GetAvailableTimeslotsPayload.new(store_id: config.store_id) }

    context "with valid payload" do

      let(:valid_payload) do
        payload_helper.payload(delivery_date: "2018-03-14")
      end

      it "returns valid response" do
        VCR.use_cassette('valid_get_available_timeslots_request') do
          response_hash = described_class.new(payload: valid_payload).execute

          expect(response_hash["success"]).to eq({"status"=>"OK"})
        end
      end
    end

    context "with invalid payload" do

      let(:invalid_payload) do
        payload_helper.payload(delivery_date: "2018-03-05") # date is in the past
      end

      it "raises 'OnTheDotApi::Errors::ResponseError' exception" do
        VCR.use_cassette('invalid_get_available_timeslots_request') do
          expect {
            described_class.new(payload: invalid_payload).execute
          }.to raise_exception(OnTheDotApi::Errors::ResponseError, "400 Bad Request")
        end
      end
    end
  end
end
