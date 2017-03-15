module StellarLookout
  class ProcessOperation

    extend LightService::Organizer

    def self.call(ward:, json:)
      with(ward: ward, json: json).reduce(
        ProcessingOperation::ParseJSON,
        ProcessingOperation::FindOrCreateTxn,
        ProcessingOperation::FindOrCreateOperation,
        ProcessingOperation::TriggerCallback,
      )
    end

  end
end
