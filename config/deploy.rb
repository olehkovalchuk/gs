# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"
set :application, "gs"
# set :repo_url, "ssh://git@git.beone.software:7999/gs/platform.git"
set :repo_url, "git@github.com:olehkovalchuk/gs.git"
set :deploy_to, "/var/www/gs_v2/#{fetch(:stage)}/#{fetch(:application)}"
set :deploy_via, :remote_cache
set :branch, ENV['BRANCH'] || proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :keep_releases, 10
set :pty, true
set :user, 'deploy'
set :port, 22
set :use_sudo, false
set :ssh_options, {
  #forward_agent: true,
  user: fetch(:user)
}
set :linked_files, ["config/secrets.yml"]
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/storage}

set :format, :pretty
set :log_level, :info
set :rvm_ruby_version, "ruby-2.6.3@#{fetch(:application)}"
SSHKit.config.command_map[:rake]  = "bundle exec rake --trace"
SSHKit.config.command_map[:rails] = "bundle exec rails"


set :sidekiq_default_hooks, true
set :sidekiq_service_name, "sidekiq_#{fetch(:application)}_#{fetch(:sidekiq_env)}"
set :sidekiq_config, File.join(release_path, 'config', 'sidekiq.yml')
set :sidekiq_processes, 1
after 'puma:restart', "sidekiq:restart"
#after 'puma:restart', "sitemap:refresh"

before 'deploy:compile_assets', 'deploy:assets:install_webpack'

after 'puma:restart', 'deploy:fb_feed'

# before "deploy:assets:precompile", "deploy:yarn_install"

# namespace :deploy do
#   desc 'Run rake yarn:install'
#   task :yarn_install do
#     on roles(:web) do
#       within release_path do
#         execute("cd #{release_path} && yarn install")
#       end
#     end
#   end
# end

namespace :deploy do
  desc "Invoke rake task"
  task :fb_feed do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "marketplace:fb_feed"
        end
      end
    end
  end
end


