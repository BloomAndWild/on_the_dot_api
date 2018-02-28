require 'spec_helper'

describe OnTheDotApi::Client do
  let(:client) { OnTheDotApi::Client }
  let(:config) { client.config }
  let(:logger) { Logger.new(STDOUT) }

  let(:base_url_example) { 'https://sbapi.onthedot.com/api' }
  let(:api_key_example) { '123456' }
  let(:store_id_example) { 'example_shop' }

  before do
    client.configure do |config|
      config.base_url = base_url_example
      config.api_key = api_key_example
      config.store_id = store_id_example
      config.logger = logger
    end
  end

  it "allows to set custom attributes" do
    expect(config.base_url).to eq(base_url_example)
    expect(config.api_key).to eq(api_key_example)
    expect(config.store_id).to eq(store_id_example)
    expect(config.logger).to eq(logger)
  end
end

