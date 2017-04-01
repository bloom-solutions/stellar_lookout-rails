require 'spec_helper'

module StellarLookout
  RSpec.describe GenCallbackUrl do

    let(:ward) { build_stubbed(:stellar_lookout_ward) }

    it "generates the callback_url for the given ward" do
      expect(described_class.(ward)).
        to eq Engine.routes.url_helpers.api_v1_ward_operations_url(ward)
    end

  end
end
