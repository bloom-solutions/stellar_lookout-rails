StellarLookout.configuration do |c|
  c.server_url = CONFIG[:server_url]
  c.on_receive = "ProcessStellarOperation"
end
