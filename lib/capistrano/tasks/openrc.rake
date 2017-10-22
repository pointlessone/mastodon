namespace :load do
  task :defaults do
    set :openrc_services, ->{ fetch :application }
    set :openrc_use_sudo, false
    set :openrc_roles, %w(app)
  end
end

namespace :openrc do
  %w(start stop restart).each do |command|
    desc "#{command.capitalize} service"
    task command do
      on roles fetch :openrc_roles do
        Array(fetch(:openrc_services)).each do |service|
          service service, command
        end
      end
    end
  end

  %w(add delete).each do |command|
    desc "#{command.capitalize} service"
    task command do
      on roles fetch :openrc_roles do
        Array(fetch(:openrc_services)).each do |service|
          rc_config service, command
        end
      end
    end
  end

  desc "Show the status of service"
  task :status do
    on roles fetch :openrc_roles do
        Array(fetch(:openrc_services)).each do |service|
          service service, command
        end
    end
  end

  def service(service, command)
    if fetch(:openrc_use_sudo)
      sudo 'rc-service', service, command
    else
      execute 'rc-service', service, command
    end
  end

  def rc_config(service, action, runlevel = 'default')
    if fetch(:openrc_use_sudo)
      sudo 'rc-config', action, service, runlevel
    else
      execute 'rc-config', action, service, runlevel
    end
  end
end
