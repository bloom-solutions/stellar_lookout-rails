module StellarLookout
  class Operation < ApplicationRecord
    belongs_to :ward
    belongs_to :txn, primary_key: :external_id, foreign_key: :txn_external_id

    store :body, coder: JSON
    include Storext.model
    store_attributes :body do
      paging_token String
      source_account String
      type String
      type_i Integer
      asset_type String
      from String
      to String
      amount BigDecimal
    end

  end
end
