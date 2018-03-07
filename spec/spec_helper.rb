require 'pry'
require 'dotenv'
require 'vcr'

require 'on_the_dot_api'

Dotenv.load

require_relative 'support/helpers/client_helper'

require_relative 'support/payloads/get_available_timeslots_payload'
require_relative 'support/payloads/create_booking_payload'

VCR.configure do |c|
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost                        = true
  c.cassette_library_dir                    = 'spec/support/fixtures/vcr_cassettes'
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options                = { match_requests_on: [:uri] }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
