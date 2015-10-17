Apipie.configure do |config|
  config.default_version         = '1.0'
  config.app_name                = "TicTacToe"
  config.api_base_url            = "/v1"
  config.doc_base_url            = "/v1/docs"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/v1/*.rb"
end
