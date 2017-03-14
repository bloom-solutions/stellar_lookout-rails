module StellarLookout
  class Ward < ApplicationRecord

    has_many :operations

    validates :address, uniqueness: true, presence: true

  end
end
