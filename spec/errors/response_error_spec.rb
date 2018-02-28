require 'spec_helper'

describe OnTheDotApi::Errors::ResponseError do
  let(:code) { "400" }
  let(:payload) { "payload example" }
  let(:http_body) { "Bad Request"}
  let(:response) { "Bad Request" }
  let(:message) { "400 Bad Request"}

  subject do
    described_class.new(
      code: code,
      payload: payload,
      http_body: http_body,
      response: response,
      message: message,
    )
  end

  it 'stores additional metadata' do
    expect { raise subject }.to raise_error do |error_object|
      expect(error_object.code).to eq(code)
      expect(error_object.payload).to eq(payload)
      expect(error_object.http_body).to eq(http_body)
      expect(error_object.response).to eq(response)
      expect(error_object.message).to eq(message)
    end
  end
end
