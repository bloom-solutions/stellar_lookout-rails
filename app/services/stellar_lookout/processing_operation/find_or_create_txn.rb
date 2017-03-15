module StellarLookout
  module ProcessingOperation
    class FindOrCreateTxn

      extend LightService::Action
      expects :transaction_body
      promises :txn

      executed do |c|
        body = c.transaction_body

        c.txn = Txn.find_by(external_id: body["id"])

        next c if c.txn.present?
        c.txn = Txn.create(external_id: body["id"], body: body)
      end

    end
  end
end
