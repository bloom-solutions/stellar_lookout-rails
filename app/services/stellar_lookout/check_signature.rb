module StellarLookout
  class CheckSignature

    def self.call(ward:, headers:, json:)
      signature_for(ward.secret, json) == signature_in_headers(headers)
    end

    private

    def self.signature_in_headers(headers)
      authorization = headers["AUTHORIZATION"]
      return nil if authorization.nil?
      authorization.match(/HMAC-SHA256\s(.*)/)[1]
    end

    def self.signature_for(key, json)
      OpenSSL::HMAC.hexdigest("SHA256", key, json)
    end

  end
end
