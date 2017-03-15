module StellarLookout
  class FindOrCreateTxn

    def self.call(remote_txn)
      txn = Txn.find_by(external_id: remote_txn["id"])
      return txn if txn.present?
      Txn.create(external_id: remote_txn["id"], body: remote_txn)
    end

  end
end
