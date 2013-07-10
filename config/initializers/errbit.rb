Airbrake.configure do |config|
  config.api_key = 'ed50c4cbf699fa25f9554efee3119b56'
  config.host    = 'errbit-bpf.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end