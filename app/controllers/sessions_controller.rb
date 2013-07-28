class SessionsController < Devise::SessionsController
  force_ssl only: [:new, :create], if: :ssl_configured?
end