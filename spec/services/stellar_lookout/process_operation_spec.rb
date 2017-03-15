require 'spec_helper'

module StellarLookout
  RSpec.describe ProcessOperation do

    let(:ward) { build_stubbed(:stellar_lookout_ward) }
    let(:operation_body) do
      file_path = FIXTURES_DIR.join("operation_12884905985.json").to_s
      JSON.parse(File.read(file_path)).with_indifferent_access
    end
    let(:transaction_body) do
      file_path = FIXTURES_DIR.
        join("transaction_3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889.json").
        to_s
      JSON.parse(File.read(file_path)).with_indifferent_access
    end
    let(:txn) { build_stubbed(:stellar_lookout_txn) }
    let(:operation) { build_stubbed(:stellar_lookout_operation, txn: txn) }
    let(:callback_class) do
      StellarLookout.configuration.on_receive.constantize
    end

    context "successfully creates an operation" do
      it "runs configured callback" do
        body = { operation: operation_body, transaction: transaction_body }

        expect(FindOrCreateTxn).to receive(:call).
          with(transaction_body).
          and_return(txn)
        expect(FindOrCreateOperation).to receive(:call).
          with(ward, txn, operation_body).
          and_return(operation)
        expect(callback_class).to receive(:call).with(operation)

        expect(described_class.(ward: ward, json: body.to_json)).
          to eq operation
      end
    end

  end
end
