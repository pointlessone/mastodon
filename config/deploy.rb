# frozen_string_literal: true

lock '3.10.2'

set :repo_url, ENV.fetch('REPO', 'https://github.com/tootsuite/mastodon.git')
set :branch, ENV.fetch('BRANCH', 'master')

set :application, 'mastodon'
gemset = File.read('.ruby-gemset').strip
gemset = fetch(:application) if gemset.empty?
set :rvm_ruby_version, "#{File.read('.ruby-version').strip}@#{gemset}"
set :migration_role, :app

append :linked_files, '.env.production', 'public/robots.txt'
append :linked_dirs, 'vendor/bundle', 'public/system'
