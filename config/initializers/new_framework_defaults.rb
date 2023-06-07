Rails.application.config.active_record.belongs_to_required_by_default = false
Rails.application.routes.default_url_options[:host] = Rails.application.secrets[:app_host]