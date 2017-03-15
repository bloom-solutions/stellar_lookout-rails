module StellarLookout
  module ProcessingOperation
    class FindOrCreateOperation

      extend LightService::Action
      expects :ward, :txn, :operation_body
      promises :operation

      executed do |c|
        body = c.operation_body

        c.operation = Operation.find_by(external_id: body["id"])

        if c.operation.present?
          c.skip_all!
          next c
        end

        c.operation = Operation.create(
          ward_id: c.ward.id,
          txn_external_id: c.txn.external_id,
          external_id: body["id"],
          body: body,
        )
      end

    end
  end
end
