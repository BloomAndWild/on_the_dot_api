require 'spec_helper'

describe OnTheDotApi::Operations::GettAllBookings do
  describe '#execute' do
    before do
      configure_client
    end

    let(:config) { OnTheDotApi::Client.config }

    it "gets all the bookings" do
      VCR.use_cassette('valid_get_all_bookings_request') do
        response_hash = described_class.new(
          params: { "pageNumber": 1, "pageSize": 25 }
        ).execute

        expect(response_hash["success"]).to eq({"status"=>"ok"})
        expect(response_hash["data"]["data"]).to eq([])
        expect(response_hash["data"]["size"]).to eq(0)
      end
    end
  end
end
