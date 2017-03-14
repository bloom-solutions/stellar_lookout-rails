require 'spec_helper'

module StellarLookout
  RSpec.describe Watch, vcr: {record: :once} do

    context "address is already being watched" do
      before do
        create(:stellar_lookout_ward, address: "123")
      end

      it "returns true" do
        result = described_class.("123")
        expect(result).to be true
      end
    end

    context "ward is valid" do
      let(:address) { SecureRandom.hex }

      it "attempts to create the ward in the stellar lookout server" do
        response = described_class.(address)
        expect(response).to be_success
      end
    end

  end
end
