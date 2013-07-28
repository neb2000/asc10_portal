MAIL_CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'mail.yml'))
ActionMailer::Base.smtp_settings = (MAIL_CONFIG || {})