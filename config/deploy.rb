# config valid for current version and patch releases of Capistrano
lock "~> 3.13.0"

set :application, "scanning"
set :repo_url, "git@github.com:awais4123/donations_scanning_app.git"
ask :git_http_password
set :log_level, :info

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute 'sudo service puma-manager restart'
    end
  end
  after  :finishing, :cleanup
  after  :finishing, :restart
end

set :deploy_to, '/home/deploy/www'
set :rvm_ruby_version, 'ruby-2.4.4@bookstore-staging'
# Defaults to :db role
set :migration_role, :app 
# Defaults to the primary :db server
set :migration_servers, -> { primary(fetch(:migration_role)) }
# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true
# Defaults to [:web]
set :assets_roles, [:web]
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
# Default value for :format is :airbrussh.
# set :format, :airbrussh
# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto
# Default value for :pty is false
# set :pty, true
# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/uploads'
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }
# Default value for keep_releases is 5
# set :keep_releases, 5
# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure