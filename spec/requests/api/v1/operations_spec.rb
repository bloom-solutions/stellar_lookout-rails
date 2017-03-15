require 'spec_helper'

RSpec.describe "/api/v1/wards/:id/operations", type: :request do

  let(:ward) { create(:stellar_lookout_ward) }
  let(:uri) do
    StellarLookout::Engine.routes.url_helpers.
      api_v1_ward_operations_url(ward)
  end
  let(:operation_body) do
    file_path = FIXTURES_DIR.join("operation_12884905985.json").to_s
    JSON.parse(File.read(file_path)).with_indifferent_access
  end
  let(:txn_body) do
    file_path = FIXTURES_DIR.join("transaction_3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889.json").to_s
    JSON.parse(File.read(file_path)).with_indifferent_access
  end
  let(:body) { { operation: operation_body, transaction: txn_body } }

  context "with a valid signature" do
    let(:hmac_signature) do
      OpenSSL::HMAC.hexdigest("SHA256", ward.secret, body.to_json)
    end

    it "creates an operation under the ward watching it" do
      post(uri, {
        params: { body: body.to_json },
        headers: { "AUTHORIZATION" => "HMAC-SHA256 #{hmac_signature}" }
      })

      expect(response).to be_success

      expect(ward.operations.count).to eq 1
      operation = ward.operations.find_by(external_id: "12884905985")
      expect(operation).to be_persisted
      expect(operation.body.to_json).to eq operation_body.to_json
      expect(operation.txn.body.to_json).to eq txn_body.to_json
    end
  end

  context "with an invalid signature" do
    let(:hmac_signature) do
      OpenSSL::HMAC.hexdigest("SHA256", "fake", body.to_json)
    end

    it "creates an operation under the ward watching it" do
      post(uri, {
        params: { body: body.to_json },
        headers: { "AUTHORIZATION" => "HMAC-SHA256 #{hmac_signature}" }
      })

      expect(response).to_not be_success
      expect(ward.operations.count).to eq 0
    end
  end

end
