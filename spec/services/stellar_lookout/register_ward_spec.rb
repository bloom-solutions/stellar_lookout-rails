require 'spec_helper'

module StellarLookout
  RSpec.describe RegisterWard do

    let(:address) { SecureRandom.hex }
    let(:secret) { SecureRandom.uuid }
    let(:ward) do
      create(:stellar_lookout_ward, address: address, secret: secret)
    end
    let(:response) { instance_double(Typhoeus::Response) }

    it "creates the ward in the server" do
      expect(Typhoeus).to receive(:post).with(
        "#{StellarLookout.configuration.server_url}/api/v1/wards",
        body: {
          data: {
            type: "wards",
            attributes: {
              address: ward.address,
              "callback-url" => GenCallbackUrl.(ward),
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
