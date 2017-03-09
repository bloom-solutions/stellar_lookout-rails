require 'spec_helper'

module StellarLookout
  RSpec.describe CreateOperation do

    let(:ward) { build_stubbed(:ward) }
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
    let(:operation) { build_stubbed(:operation) }
    let(:callback_class) do
      StellarLookout.configuration.on_receive.constantize
    end

    context "successfully creates an operation" do
      it "runs configured callback" do
        expect(Operation).to receive(:create).
          with(ward_id: ward.id, body: JSON.parse(operation_body.to_json)).
          and_return(operation)
        expect(callback_class).to receive(:call).with(operation)

        expect(described_class.(ward: ward, json: operation_body.to_json)).
          to eq operation
      end
    end

  end
end
