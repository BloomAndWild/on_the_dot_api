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
OnTheDotApi::Operations::GetAvailableTimeslots.new(payload: {YOUR PAYLOAD}).execute
```

Implements - http://developers.onthedot.com/docs/#TimeslotV2.

#### Create a booking

```
OnTheDotApi::Operations::CreateBooking.new(
  payload: {YOUR PAYLOAD},
  headers: { "UUID": {UUID FROM TIMESLOTS RESPONSE} }
).execute
```

Implements - http://developers.onthedot.com/docs/#create-booking.

#### Cancel booking

```
OnTheDotApi::Operations::CancelBooking.new(
  order_number: {OnTheDot API ORDER NUMBER}
).execute
```

Implements - http://developers.onthedot.com/docs/#cancel-booking.

#### Retrieve booking

```
OnTheDotApi::Operations::RetrieveBooking.new(
  order_number: {OnTheDot API ORDER NUMBER}
).execute
```

Implements - http://developers.onthedot.com/docs/#retrieve-booking.

#### Amend booking

```
OnTheDotApi::Operations::AmendBooking.new(
  payload: {YOUR PAYLOAD},
  headers: { "UUID": {UUID FROM TIMESLOTS RESPONSE} }
).execute
```

Notice: payload should include order number.

Implements - http://developers.onthedot.com/docs/#amend-booking.

### Get all bookings

```
OnTheDotApi::Operations::GettAllBookings.new(
  headers: { params: { "pageNumber": 1, "pageSize": 25 }}
).execute
```

Implements - http://developers.onthedot.com/docs/#get-all-bookings.

#### Track delivery

```
OnTheDotApi::Operations::TrackDelivery.new(
  order_number: {OnTheDot API ORDER NUMBER}
).execute
```

Implements - http://developers.onthedot.com/docs/#tracking-delivery.

### Testing

To run rspec specs you need to have OnTheDot API sandbox credentials (Api key and shop id). Those credentials should be added to `.env` file. `.env.sample` file is provided as example.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
