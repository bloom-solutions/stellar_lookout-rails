require 'spec_helper'

module StellarLookout
  RSpec.describe Operation, type: %i[model] do

    describe "associations" do
      it { is_expected.to belong_to(:ward) }
      it do
        is_expected.to belong_to(:txn).
          with_primary_key(:external_id).
          with_foreign_key(:txn_external_id)
      end
    end

    describe "attributes" do
      it { is_expected.to have_attribute(:paging_token, String) }
      it { is_expected.to have_attribute(:source_account, String) }
      it { is_expected.to have_attribute(:type, String) }
      it { is_expected.to have_attribute(:type_i, Integer) }
      it { is_expected.to have_attribute(:asset_type, String) }
      it { is_expected.to have_attribute(:from, String) }
      it { is_expected.to have_attribute(:to, String) }
      it { is_expected.to have_attribute(:amount, BigDecimal) }
    end

  end
end
