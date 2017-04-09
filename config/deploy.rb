lock '3.7.2'

set :application, 'mastodon'
set :repo_url, 'https://github.com/pointlessone/mastodon.git'
set :branch, 'pointlessone'
gemset = File.read('.ruby-gemset').strip
gemset = fetch(:application) if gemset.empty?
set :rvm_ruby_version, "#{File.read('.ruby-version').strip}@#{gemset}"
set :migration_role, :app

append :linked_files, '.env.production'
append :linked_dirs, 'vendor/bundle', 'node_modules', 'public/system'
