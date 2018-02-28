# OnTheDotApi
OnTheDot API ruby wrapper. OnTheDot API documentation - http://developers.onthedot.com/docs/#overview

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'on_the_dot_api'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install on_the_dot_api
```

## Usage

### Client configuration

First you need to configure the client (if using Rails, place in an initializer):
```
OnTheDotApi::Client.configure do |config|
  config.base_url = # Base url used to communicate with the OnTheDot API
  config.api_key = # Api key used for authentication.
  config.store_id = # Store id.
  config.logger = Logger.new(STDOUT) # Your choice of logger.
end
```

### Operations

#### Get available timeslots

```
OnTheDotApi::Operations::GetAvailableTimeslots.new(payload).execute
```

Implements - http://developers.onthedot.com/docs/#TimeslotV2.

### Testing

To run rspec specs you need to have OnTheDot API sandbox credentials (Api key and shop id). Those credentials should be added to `.env` file. `.env.sample` file is provided as example.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
