module StellarLookout
  class Operation < ApplicationRecord
    belongs_to :ward

    store :body, coder: JSON
    include Storext.model
    store_attributes :body do
      id String
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
