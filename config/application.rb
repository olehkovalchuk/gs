require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GlobalSupplies
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil


    config.i18n.available_locales = %i[en]
    config.i18n.default_locale = :en
    config.i18n.enforce_available_locales = true

    config.active_job.queue_adapter = :sidekiq

    config.use_webpack = true

    config.middleware.use I18n::JS::Middleware

    config.time_zone = 'Europe/Kiev'

    # config.web_console.whitelisted_ips = '172.22.0.1'
    # config.active_storage.analyzers = []
    # config.active_storage.previewers = []

    config.active_storage.routes_prefix = '/files'


  # Mount Action Cable outside main process or domain.
    config.action_cable.mount_path = nil
    config.action_cable.url = "ws://localhost:3000/cable"
    config.action_cable.allowed_request_origins = [ 'http://localhost', /http:\/\/localhost.*/ ]
    config.web_socket_server_url = "ws://localhost:3000/cable"
    config.action_controller.default_url_options = { :trailing_slash => true }



  end
end

