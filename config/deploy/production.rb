server '138.201.234.131', user: 'gsuser', port: 2244, roles: [:web, :app, :db], primary: true
#server '176.9.103.19', user: 'deploy', port: 22, roles: [:web, :app, :db], primary: true


set :keep_releases, 3
set :branch, :master
sitemaps = (1..13).to_a.map{|i| "public/sitemap#{i}.xml" }

set :linked_files, ["config/secrets.yml", "public/sitemap.xml", "credentials.yml.enc", "config/google.json"].concat(sitemaps)

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system node_modules storage public/storage}
after 'deploy:publishing', 'deploy:restart'




