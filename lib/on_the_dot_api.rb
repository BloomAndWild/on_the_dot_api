require 'faraday'

require 'on_the_dot_api/version'
require 'on_the_dot_api/config'
require 'on_the_dot_api/client'

require 'on_the_dot_api/errors/response_error'

require 'on_the_dot_api/operation'
require 'on_the_dot_api/operations/get_available_timeslots'
require 'on_the_dot_api/operations/create_booking'
require 'on_the_dot_api/operations/cancel_booking'
require 'on_the_dot_api/operations/retrieve_booking'
require 'on_the_dot_api/operations/amend_booking'
require 'on_the_dot_api/operations/track_delivery'
require 'on_the_dot_api/operations/get_all_bookings'

module OnTheDotApi
end
