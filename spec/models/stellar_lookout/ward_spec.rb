require 'spec_helper'

module StellarLookout
  RSpec.describe Ward, type: %i[model] do

    describe "associations" do
      it { is_expected.to have_many(:operations) }
    end

    describe "validations" do
      subject { create(:ward) }
      it { is_expected.to validate_uniqueness_of(:address) }
      it { is_expected.to validate_presence_of(:address) }
    end

  end
end
