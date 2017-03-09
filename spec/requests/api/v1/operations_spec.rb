require 'spec_helper'

RSpec.describe "/api/v1/wards/:id/operations", type: :request do

  let(:ward) { create(:ward) }
  let(:uri) do
    StellarLookout::Engine.routes.url_helpers.
      api_v1_ward_operations_url(ward)
  end
  let(:operation_body) do
    {
      _links: {
        self: {
          href: "https://horizon.stellar.org/operations/12884905986"
        },
        transaction: {
          href: "https://horizon.stellar.org/transactions/3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889"
        },
        effects: {
          href: "https://horizon.stellar.org/operations/12884905986/effects"
        },
        succeeds: {
          href: "https://horizon.stellar.org/effects?order=desc&cursor=12884905986"
        },
        precedes: {
          href: "https://horizon.stellar.org/effects?order=asc&cursor=12884905986"
        }
      },
      id: "12884905986",
      paging_token: "12884905986",
      source_account: "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7",
      type: "payment",
      type_i: 1,
      asset_type: "native",
      from: "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7",
      to: "GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB",
      amount: "99999999959.9999700"
    }
  end

  context "with a valid signature" do
    let(:hmac_signature) do
      OpenSSL::HMAC.hexdigest("SHA256", ward.secret, operation_body.to_json)
    end

    it "creates an operation under the ward watching it" do
      post(uri, {
        params: {body: operation_body.to_json},
        headers: { "AUTHORIZATION" => "HMAC-SHA256 #{hmac_signature}" }
      })

      expect(response).to be_success

      expect(ward.operations.count).to eq 1
      operation = ward.operations.first
      expect(operation.body.to_json).to eq operation_body.to_json
    end
  end

  context "with an invalid signature" do
    let(:hmac_signature) do
      OpenSSL::HMAC.hexdigest("SHA256", "fake", operation_body.to_json)
    end

    it "creates an operation under the ward watching it" do
      post(uri, {
        params: {body: operation_body.to_json},
        headers: { "AUTHORIZATION" => "HMAC-SHA256 #{hmac_signature}" }
      })

      expect(response).to_not be_success
      expect(ward.operations.count).to eq 0
    end
  end

end
