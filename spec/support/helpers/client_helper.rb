def configure_client
  OnTheDotApi::Client.configure do |config|
    config.base_url = ENV.fetch('BASE_URL')
    config.api_key = ENV.fetch('API_KEY')
    config.store_id = ENV.fetch('STORE_ID')
    config.logger = Logger.new(STDOUT)
  end
end
