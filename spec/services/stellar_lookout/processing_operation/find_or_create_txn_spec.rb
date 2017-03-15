require 'spec_helper'

module StellarLookout
  module ProcessingOperation
    RSpec.describe FindOrCreateTxn do

      let(:resulting_ctx) do
        described_class.execute(transaction_body: transaction_body)
      end
      subject(:resulting_txn) { resulting_ctx.txn }

      context "txn already exists" do
        let!(:txn) { create(:stellar_lookout_txn, external_id: "b4") }
        let(:transaction_body) { {"id" => "b4"} }
        it { is_expected.to eq txn }
      end

      context "txn does not exist" do
        let(:transaction_body) { { "id" => "b3", "operation_count" => 4 } }

        it "returns that txn" do
          expect(resulting_txn.external_id).to eq "b3"
          expect(resulting_txn.body[:id]).to eq "b3"
          expect(resulting_txn.body[:operation_count]).to eq 4
        end
      end

    end
  end
end
