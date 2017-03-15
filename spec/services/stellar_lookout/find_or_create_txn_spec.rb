require 'spec_helper'

module StellarLookout
  RSpec.describe FindOrCreateTxn do

    context "txn already exists" do
      let!(:txn) { create(:stellar_lookout_txn, external_id: "b4") }

      it "returns that txn" do
        expect(described_class.({"id" => "b4"})).to eq txn
      end
    end

    context "txn does not exist" do
      let(:remote_txn) do
        { "id" => "b3", "operation_count" => 4 }
      end

      it "returns that txn" do
        txn = described_class.(remote_txn)
        expect(txn.external_id).to eq "b3"
        expect(txn.body[:id]).to eq "b3"
        expect(txn.body[:operation_count]).to eq 4
      end
    end

  end
end
