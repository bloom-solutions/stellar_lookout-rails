module StellarLookout
  class FindOrCreateOperation

    def self.call(ward, txn, remote_operation)
      operation = Operation.find_by(external_id: remote_operation["id"])
      return operation if operation.present?
      Operation.create(
        ward_id: ward.id,
        txn_external_id: txn.external_id,
        external_id: remote_operation["id"],
        body: remote_operation,
      )
    end

  end
end
