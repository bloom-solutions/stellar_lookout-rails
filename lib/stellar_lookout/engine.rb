module StellarLookout
  class Engine < ::Rails::Engine
    isolate_namespace StellarLookout

    config.to_prepare do
      Engine.routes.default_url_options =
        Rails.application.routes.default_url_options
    end
  end
end
