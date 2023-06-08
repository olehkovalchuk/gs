source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0.rc1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# source "https://gems.beone.software" do
#   gem 'be_one_admin', '0.3.2'
# end
gem 'be_one_admin', git: "https://github.com/olehkovalchuk/be_one_admin.git"
gem 'be_one_core', git: "https://github.com/olehkovalchuk/be_one_core.git"

# gem 'be_one_admin', path: "components"
# path "components" do
#   gem 'be_one_admin', '0.2.66'
# end
gem 'vueonrails'
gem 'image_processing'
gem 'kaminari'
gem 'ltree_hierarchy'
gem "i18n-js"
gem 'geoip'
gem 'gon'
gem 'gibbon'


group :development do
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.3", require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano-nvm', require: false
  gem 'capistrano-webpacker-precompile', require: false

end

gem "sidekiq"
gem "sidekiq-failures"
gem "sidekiq-limit_fetch"
gem "sidekiq-scheduler"
gem "sidekiq-benchmark"

gem 'paypal-sdk-rest'

gem 'active_model_otp'
gem 'render_anywhere', require: false
gem "recaptcha"
gem 'telegram-bot'
gem 'google-cloud-storage'

gem 'pdfkit'
gem 'wkhtmltopdf-binary'
gem "redis-namespace"
gem "sitemap_generator"
gem 'logstash-logger'
gem 'csv'
gem 'gmail'
gem 'rest-client'
gem 'newrelic_rpm'

