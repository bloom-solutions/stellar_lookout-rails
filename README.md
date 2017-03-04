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

## Usage
### Configure

In an initializer,

```
StellarLookout.configure do |c|
  c.priority_levels = {
    high: { num: 0, interval: 6..20 }, # see below for an explanation of these values
    low: { num: 1, interval: 6..200 },
  }
  c.on_receive = "ProcessStellarOperation" # you create this callback class. More on this later.
end
```

A few things about priority levels:

- `priority_levels` configures an ActiveRecord Enum in the `StellarLookout::Ward` model. Therefore, you must specify a `num` integer that *should not* change unless you know what you're doing (it's like changing the number of an Enum)
- `disabled` is reserved with a num of `-100`. If you attempt to use either of these values, you should see an error.
- You will specify schedule that your background worker will check for wards that should be activated, I suggest nothing shorter than 6 seconds because a legder, as of today, takes almost 6 seconds to close. Anything quicker may pick up the next ledgers sooner, but most apps can afford to wait.
- `interval` describes what the range will be of how often the ward will be triggered. It will increase in a fibonacci sequence starting at `8` until the max specified in your interval or until a new payment comes in. Given an interval of `6..200`, the ward will be triggered around:
  - 6 + 8 seconds after it is created, no new payment detected
  - 6 + 13 seconds after the last check, no new payment detected
  - 6 + 21 seconds after the last check, no new payment detected
  - 6 + 34 seconds after the last check, *new* payment detected - reset interval
  - 6 + 8 seconds after the last check, no new payment detected
  - 6 + 13 seconds after the last check, no new payment detected
  - ... same sequence without new payments detected, until:
  - 6 + 144 seconds after the last check. It will continue to check around every 150 seconds because the next sequence is greater than 200.

#### Callback Class

In your application code, create a callback class. Let's say it's called `ProcessStellarOperation`:

```ruby
class ProcessStellarOperation
  def self.call(op)
    # You can do what you want here. `op` that is passed is a `StellarLookout::Operation`.
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

#### Schedule

In a scheduler, execute the `StellarLookout::Job` every 6 seconds. If you're using [sidekiq-cron](https://github.com/ondrejbartas/sidekiq-cron), put this in your schedule yaml:

```yaml
my_first_job:
cron: "*/6 * * * *"
class: "StellarLookout::Job"
```

Manage wards:

```
ward = StellarLookout::Ward.create(
  address: "GAT6VDPXX26XXFAKACUJTIZAL3GSFJ4NECG7B3C3P63IP4233XFP2PCS",
  priority: "high",
)

ward.disable! # disable a ward, checks will no longer be performed
ward.low! # make this ward low priority
ward.update_attributes(priority: "low") # since we're using enum, this will work too

ward.operations # scope of `StellarLookout::Operation` models

StellarLookout::Ward.low # returns all low priority wards
StellarLookout::Ward.high # returns all high priority wards
StellarLookout::Ward.disabled # returns all disabled wards
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
