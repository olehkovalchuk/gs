ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = Rails.application.secrets[:smtp]
ActionMailer::Base.default_url_options = { host: "#{Rails.env.production? ? "" : "#{Rails.env}."}#{Rails.application.secrets[:app_host]}",protocol: Rails.env.production? ? 'http' : 'http' }
