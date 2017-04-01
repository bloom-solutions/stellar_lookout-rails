module StellarLookout
  class Watch

    def self.call(address, host: StellarLookout.configuration.server_url)
      ward = Ward.find_by(address: address) ||
        Ward.create(address: address, secret: SecureRandom.uuid)

      return ward if ward.invalid?

      RegisterWard.(ward, host: host)
    end

  end
end
