require "yaml"

CONFIG_FILE_PATH = StellarLookout::Engine.root.join("spec", "config.yml")
CONFIG = YAML.load_file(CONFIG_FILE_PATH).with_indifferent_access

StellarLookout.configure do |c|
  c.server_url = CONFIG[:stellar_lookout_url]
  c.on_receive = "ProcessStellarOperation"
end

