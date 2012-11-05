require "bundler/capistrano"
set :user, 'william'
set :domain, 'depot.linuxcbt.com'
set :application, 'depot'

# adjust if you are using RVM, remove if you are not
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.3'

# file paths
set :repository,  "https://github.com/williamherry/depot.git"
set :deploy_to, "/home/#{user}/#{application}"

role :app, "192.168.33.10"
role :web, "192.168.33.10"
role :db, "192.168.33.10", :primary => true

# miscellaneous options
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, :production

namespace :deploy do
  desc "cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
end

after "deploy:update_code", :bundle_install
desc "install the necessary prerequisites"
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install"
end
