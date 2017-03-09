module StellarLookout
  class CreateOperation

    def self.call(ward:, json:)
      operation = Operation.create(ward_id: ward.id, body: JSON.parse(json))
      callback_class.(operation)
      operation
    end

    private

    def self.callback_class
      StellarLookout.configuration.on_receive.constantize
    end

  end
end
