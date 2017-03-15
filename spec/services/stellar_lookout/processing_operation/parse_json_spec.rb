require 'spec_helper'

module StellarLookout
  module ProcessingOperation
    RSpec.describe ParseJSON do

      let(:json) do
        {
          operation: {hi: "operation"},
          transaction: {hi: "transaction"},
        }.to_json
      end

      it "parses the json and sets operation and transaction body in the context" do
        resulting_ctx = described_class.execute(json: json)

        expect(resulting_ctx.operation_body[:hi]).to eq "operation"
        expect(resulting_ctx.transaction_body[:hi]).to eq "transaction"
      end

    end
  end
end
