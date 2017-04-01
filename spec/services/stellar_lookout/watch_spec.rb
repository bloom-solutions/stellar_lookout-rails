require 'spec_helper'

module StellarLookout
  RSpec.describe Watch, vcr: {record: :once} do

    context "ward for address exists" do
      before do
        create(:stellar_lookout_ward, address: "123")
      end

      it "attempts to register existing ward" do
        response = described_class.("123")
        expect(response).to be_success
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
