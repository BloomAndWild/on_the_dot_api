require 'spec_helper'

describe OnTheDotApi::Operations::GetAvailableTimeslots do
  describe '#execute' do
    before do
      configure_client
    end

    let(:config) { OnTheDotApi::Client.config }

    context "with valid payload" do

      let(:valid_payload) {
        {
          consumer: {
            address: {
              postCode: "SE11 5QY"
            }
          },
          items: {
            readyAt: "2018-03-05T09:00:00Z",
            deliveryDates: [
              {
                deliveryDate: "2018-03-05",
                openTime: "09:00",
                closeTime: "18:00"
              },
              {
                deliveryDate: "2018-03-06",
                openTime: "09:00",
                closeTime: "18:00"
              },
            ],
          },
          store: {
            storeId: config.store_id,
            timeslotDuration: 2
          }
        }
      }

      it "returns valid response" do
        VCR.use_cassette('valid_get_available_timeslots_request') do
          response_hash = described_class.new(valid_payload).execute

          expect(response_hash["success"]).to eq({"status"=>"OK"})
        end
      end
    end

    context "with invalid payload" do

      let(:invalid_payload) {
        {
          consumer: {
            address: {
              postcode: "SE11 5QY" # misspelled key
            }
          },
          items: {
            readyAt: "2018-03-05T09:00:00Z",
            deliveryDates: [
              {
                deliveryDate: "2018-03-05",
                openTime: "09:00",
                closeTime: "18:00"
              },
              {
                deliveryDate: "2018-03-06",
                openTime: "09:00",
                closeTime: "18:00"
              },
            ],
          },
          store: {
            storeId: config.store_id,
            timeslotDuration: 2
          }
        }
      }

      it "raises 'OnTheDotApi::Errors::ResponseError' exception" do
        VCR.use_cassette('invalid_get_available_timeslots_request') do
          expect {
            described_class.new(invalid_payload).execute
          }.to raise_exception(OnTheDotApi::Errors::ResponseError, "400 Bad Request")
        end
      end
    end
  end
end
