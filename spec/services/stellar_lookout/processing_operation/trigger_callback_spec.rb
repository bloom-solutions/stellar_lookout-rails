require 'spec_helper'

module StellarLookout
  module ProcessingOperation
    RSpec.describe TriggerCallback do

      let(:operation) { build_stubbed(:stellar_lookout_operation) }

      it "triggers the configured callback class" do
        expect(ProcessStellarOperation).to receive(:call).with(operation)
        described_class.execute(operation: operation)
      end

    end
  end
end
