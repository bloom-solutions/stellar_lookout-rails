module StellarLookout
  module ProcessingOperation
    class ParseJSON

      KEYS = %i[operation_body transaction_body]

      extend LightService::Action
      expects :json
      promises(*KEYS)

      executed do |c|
        parsed_json = JSON.parse(c.json).with_indifferent_access
        c.operation_body = parsed_json[:operation]
        c.transaction_body = parsed_json[:transaction]
      end

    end
  end
end
