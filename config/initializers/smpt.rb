ActionMailer::Base.raise_delivery_errors = true
if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = Rails.application.secrets[:smtp]
end
ActionMailer::Base.default_url_options = { host: "#{Rails.env.production? ? "" : "#{Rails.env}."}#{Rails.application.secrets[:app_host]}",protocol: Rails.env.production? ? 'http' : 'http' }
