require 'spec_helper'

module StellarLookout
  module ProcessingOperation
    RSpec.describe FindOrCreateOperation do

      let(:ward) { create(:stellar_lookout_ward) }
      let(:txn) { create(:stellar_lookout_txn) }
      let(:operation_body) do
        file_path = FIXTURES_DIR.join("operation_12884905985.json").to_s
        JSON.parse(File.read(file_path)).with_indifferent_access
      end
      let(:resulting_ctx) do
        described_class.execute({
          ward: ward,
          txn: txn,
          operation_body: operation_body,
        })
      end
      subject(:resulting_operation) { resulting_ctx.operation }

      context "operation already exists" do
        let!(:operation) do
          create(:stellar_lookout_operation, {
            txn: txn,
            ward: ward,
            external_id: "12884905985",
          })
        end

        it { is_expected.to eq operation }

        it "sets the operation and skips the rest of the steps" do
          expect(resulting_operation).to eq operation
          expect(resulting_ctx).to be_skip_all
        end
      end

      context "operation does not exist" do
        it "creates the operation" do
          expect(resulting_operation.ward).to eq ward
          expect(resulting_operation.txn).to eq txn
          expect(resulting_operation.external_id).to eq "12884905985"
          expect(resulting_operation.body[:source_account]).
            to eq "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7"
        end
      end

    end
  end
end
