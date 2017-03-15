require 'spec_helper'

module StellarLookout
  RSpec.describe ProcessOperation do

    it "calls actions in order" do
      actions = [
        ProcessingOperation::ParseJSON,
        ProcessingOperation::FindOrCreateTxn,
        ProcessingOperation::FindOrCreateOperation,
        ProcessingOperation::TriggerCallback,
      ]

      ward = build_stubbed(:stellar_lookout_ward)
      json = {hi: "there"}.to_json
      ctx = LightService::Context.new(ward: ward, json: json)

      actions.each do |action|
        expect(action).to receive(:execute).with(ctx).and_return(ctx)
      end

      described_class.(ward: ward, json: json)
    end

  end
end
