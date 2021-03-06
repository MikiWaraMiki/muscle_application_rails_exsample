# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "muscle_application"
set :repo_url, "git@github.com:MikiWaraMiki/muscle_application_rails_exsample.git"

set :branch, 'master'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/rails"


# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/master.key', 'config/database.yml')

# append :linked_files, "config/database.yml"
# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'run/pids', 'run/cache', 'run/sockets', 'vendor/bundle', 'public/system')
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Rbenv
set :rbenv_ruby, '2.6.2'

# Log level
set :loglevel, :debug


# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure


# Deploy task
namespace :deploy do
    desc 'Restart Application'
    task :restart do
        invoke 'unicorn:restart'
    end

    desc "Create Database"
    task :db_create do
        on roles(:db) do |host|
            with rails_env: fetch(:rails_env) do
                execute :bundle, :exec, :rake, 'db:create'
            end
        end
    end

    desc "Run seed"
    task :seed do
        on roles(:app) do
            with rails_env: fetch(:rails_env) do
                execute :bundle, :exec, :rake , 'db:seed'
            end
        end
    end

    after :publishing, :restart

    after :restart, :clear_cache do
        on roles(:app), in: :groups, limit:3, wait:10 do
        end
    end
end