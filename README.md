# StellarLookout

Watch Stellar payments for multiple addresses in a reliable manner. You create a Ward record per address you want to keep track of.

This gem:

- in case of downtime, will be able to backtrack to unprocessed payments when the connection is resumed (do not rely on SSE)
- rely on a background worker to efficiently query addresses that you care about
- be efficient with the calls; have back-off so that older "wards" check less frequently
- is customizable enough to have different levels of priority
- be able to disable wards for addresses you no longer care about

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'stellar_lookout'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install stellar_lookout
```

Copy the migrations over:

```bash
rails stellar_lookout:install:migrations
rake db:migrate
```

## Usage
### Configure

In an initializer:

```ruby
StellarLookout.configure do |c|
  c.server_url = "https://stellar-lookout-server.com" # https://github.com/imacchiato/stellar_lookout server
  c.on_receive = "ProcessStellarOperation" # you create this callback class. More on this later.
end
```

### Watch an address

```ruby
# If ward is valid (i.e. address is unique, you get a Typhoeus::Response back)
response = StellarLookout::Watch.("GAT6VDPXX26XXFAKACUJTIZAL3GSFJ4NECG7B3C3P63IP4233XFP2PCS")
response.body # {"data":{"id":"1","type":"wards","links":{"self":"https://stellar-lookout-server.com/api/v1/wards/1"},"attributes":{"address":"53a83253c5b3a5f61b296ed439adf40e","callback-url":"http://localhost:3000/stellar_lookout/api/v1/operations","secret":"dec24e94-1dd9-4326-b14d-25ad87e195d1"}}}
```

```ruby
# If ward is invalid, non-persisted ward:
ward = StellarLookout::Watch.("GAT6VDPXX26XXFAKACUJTIZAL3GSFJ4NECG7B3C3P63IP4233XFP2PCS")
ward.persisted? # false
ward.errors
```

This is makes an HTTP call to the configured StellarLookout server.

#### Callback Class

In your application code, create a callback class. Let's say it's called `ProcessStellarOperation`:

```ruby
class ProcessStellarOperation
  def self.call(op)
    # You can do what you want here. `op` that is passed is a `StellarLookout::Operation`.
    # This is executed within a controller request. If you will be doing anything heavy, enqueue it to a background worker.
  end
end
```

A `StellarLookout::Operation` will model the json that is returned, except the `_links`.

```ruby
op.id # "3330798677659649"
op.paging_token # "3330798677659649"
op.source_account # "GDBYR5T4TQL6M73A4ER67H2JFTVITDJO7FDK37KY6APPQD6AWEW3ESGY"
op.type # "payment"
op.type_i # 1
op.asset_type # "native"
op.from # "GDBYR5T4TQL6M73A4ER67H2JFTVITDJO7FDK37KY6APPQD6AWEW3ESGY"
op.to # "GAT6VDPXX26XXFAKACUJTIZAL3GSFJ4NECG7B3C3P63IP4233XFP2PCS"
op.amount # 1000.0 => instead of a string, which is what the JSON returns, `BigDecimal` is returned so you can easily apply math operations
```

## Factories

To make development easier, if you use factory girl, you can include factories in your application: `require "stellar_lookout/factories"`.

- `:stellar_lookout_operation`
- `:stellar_lookout_ward`

## Contributing

- Copy `spec/config.yml.sample` to `spec/config.yml` and fill it up.
- `rspec spec`
- Submit a pull request

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
