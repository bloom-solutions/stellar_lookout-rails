module StellarLookout
  class Watch

    def self.call(address, host: StellarLookout.configuration.server_url)
      ward = Ward.find_by(address: address)
      return true if ward.present?

      # NOTE: unable to test because I do not know how to create an invalid ward
      # at this point
      ward = Ward.create(address: address, secret: SecureRandom.uuid)
      return ward if ward.invalid?

      RegisterWard.(ward, host: host)
    end

  end
end
