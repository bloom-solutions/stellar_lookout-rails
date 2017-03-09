require 'spec_helper'

module StellarLookout
  RSpec.describe RegisterWard do

    let(:address) { SecureRandom.hex }
    let(:secret) { SecureRandom.uuid }
    let(:callback_url) do
      Engine.routes.url_helpers.api_v1_ward_operations_url(ward)
    end
    let(:ward) { create(:ward, address: address, secret: secret) }
    let(:response) { instance_double(Typhoeus::Response) }

    it "creates the ward in the server" do
      expect(Typhoeus).to receive(:post).with(
        "#{StellarLookout.configuration.server_url}/api/v1/wards",
        body: {
          data: {
            type: "wards",
            attributes: {
              address: ward.address,
              "callback-url" => callback_url,
              secret: secret,
            }
          }
        }.to_json,
        headers: {
          "Content-Type" => "application/vnd.api+json",
          "Accept" => "application/vnd.api+json",
        }
      ).and_return(response)

      described_class.(ward)
    end

  end
end
