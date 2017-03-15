module StellarLookout
  class ProcessOperation

    def self.call(ward:, json:)
      body = JSON.parse(json).with_indifferent_access
      operation_body = body[:operation]
      transaction_body = body[:transaction]

      txn = FindOrCreateTxn.(transaction_body)
      operation = FindOrCreateOperation.(ward, txn, operation_body)
      callback_class.(operation)
      operation
    end

    private

    def self.callback_class
      StellarLookout.configuration.on_receive.constantize
    end

  end
end
