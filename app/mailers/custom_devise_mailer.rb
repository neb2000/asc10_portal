class CustomDeviseMailer < Devise::Mailer
  default from: "no-reply@asc10.eu"
  before_action :setup_header
  
  private
    def setup_header
      headers 'Reply-to' => 'no-reply@asc10.eu'
    end
end
