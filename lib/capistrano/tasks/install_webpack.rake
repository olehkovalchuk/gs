#lib/capistrano/tasks/install_webpack.rake
namespace :deploy do
  namespace :assets do
    task :install_webpack do
      on roles(:app) do
        within release_path do
          with rails_env: fetch(:stage) do
            execute :yarn, "install"
            execute :rake , "webpacker:binstubs"
          end
        end
      end
    end
  end
end