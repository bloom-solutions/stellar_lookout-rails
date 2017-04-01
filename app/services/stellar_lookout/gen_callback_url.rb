module StellarLookout
  class GenCallbackUrl

    def self.call(ward)
      Engine.routes.url_helpers.api_v1_ward_operations_url(ward)
    end

  end
end
