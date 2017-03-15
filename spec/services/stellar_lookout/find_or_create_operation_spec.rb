require 'spec_helper'

module StellarLookout
  RSpec.describe FindOrCreateOperation do

    let(:ward) { create(:stellar_lookout_ward) }
    let(:txn) { create(:stellar_lookout_txn) }
    let(:remote_operation) do
      file_path = FIXTURES_DIR.join("operation_12884905985.json").to_s
      JSON.parse(File.read(file_path)).with_indifferent_access
    end

    context "operation already exists" do
      let!(:operation) do
        create(:stellar_lookout_operation, {
          txn: txn,
          ward: ward,
          external_id: "12884905985",
        })
      end

      it "returns that operation" do
        expect(described_class.(ward, txn, remote_operation)).to eq operation
      end
    end

    context "operation does not exist" do
      it "returns that operation" do
        operation = described_class.(ward, txn, remote_operation)
        expect(operation.ward).to eq ward
        expect(operation.txn).to eq txn
        expect(operation.external_id).to eq "12884905985"
        expect(operation.body[:source_account]).
          to eq "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7"
      end
    end

  end
end
