require 'spec_helper'

module StellarLookout
  RSpec.describe Watch, vcr: {record: :once} do

    context "ward is invalid" do
      before do
        create(:ward, address: "123")
      end

      it "returns the invalid ward" do
        ward = described_class.("123")
        expect(ward).to be_invalid
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
