module StellarLookout
  class Txn < ApplicationRecord

    has_many(:operations, {
      primary_key: :external_id,
      foreign_key: :txn_external_id,
    })

    store :body, coder: JSON
    include Storext.model
    store_attributes :body do
      paging_token String
      ledger Integer
      created_at String
      source_account String
      source_account_sequence String
      fee_paid Integer
      operation_count Integer
      envelope_xdr String
      result_xdr String
      result_meta_xdr String
      fee_meta_xdr String
      memo_type String
      memo String
      signatures Array[String]
    end
    store_attribute :body, :hash, String

  end
end
