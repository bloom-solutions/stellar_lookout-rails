require 'spec_helper'

module StellarLookout
  RSpec.describe Txn, type: %i[model] do

    describe "associations" do
      it do
        is_expected.to have_many(:operations).
          with_primary_key(:external_id).
          with_foreign_key(:txn_external_id)
      end
    end

    describe "attributes" do
      it { is_expected.to have_attribute(:paging_token, String) }
      it { is_expected.to have_attribute(:hash, String) }
      it { is_expected.to have_attribute(:ledger, Integer) }
      it { is_expected.to have_attribute(:created_at, String) }
      it { is_expected.to have_attribute(:source_account, String) }
      it { is_expected.to have_attribute(:source_account_sequence, String) }
      it { is_expected.to have_attribute(:fee_paid, Integer) }
      it { is_expected.to have_attribute(:operation_count, Integer) }
      it { is_expected.to have_attribute(:envelope_xdr, String) }
      it { is_expected.to have_attribute(:result_xdr, String) }
      it { is_expected.to have_attribute(:result_meta_xdr, String) }
      it { is_expected.to have_attribute(:fee_meta_xdr, String) }
      it { is_expected.to have_attribute(:memo_type, String) }
      it { is_expected.to have_attribute(:memo, String) }
      it { is_expected.to have_attribute(:signatures, Array[String]) }
    end

  end
end
