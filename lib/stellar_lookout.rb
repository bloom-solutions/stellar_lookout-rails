require "gem_config"
require "jsonapi-resources"
require "storext"
require "typhoeus"
require "stellar_lookout/engine"

module StellarLookout

  include GemConfig::Base

  with_configuration do
    has :server_url
    has :on_receive
  end

end
