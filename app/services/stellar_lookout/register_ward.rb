module StellarLookout
  class RegisterWard

    def self.call(ward, host: StellarLookout.configuration.server_url)
      Typhoeus.post(uri(host), {
        body: {
          data: {
            type: "wards",
            attributes: {
              address: ward.address,
              "callback-url" => GenCallbackUrl.(ward),
              secret: ward.secret,
            }
          }
        }.to_json,
        headers: {
          "Content-Type" => "application/vnd.api+json",
          "Accept" => "application/vnd.api+json",
        }
      })
    end

    private

    def self.uri(host)
      uri = URI.parse(host)
      uri.path = "/api/v1/wards"
      uri.to_s
    end

  end
end
