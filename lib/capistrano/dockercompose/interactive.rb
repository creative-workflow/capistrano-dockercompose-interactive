require 'sshkit/interactive'
require_relative '../tasks/default.rb'
require_relative './interactive/instance'

module DockerCompose
  module Interactive

    def self.instance(file='', project='')
      Instance.new(file, project)
    end

    def self.local_stage?
      fetch(:local_stage_name, 'local').to_sym == fetch(:stage).to_sym
    end

    def self.capture_local_or_remote(cmd)
      puts "runnig: docker-compose #{cmd}"
      result = ''
      if local_stage?
        run_locally do
          result = capture "docker-compose #{cmd}"
        end
      else
        on roles fetch(:docker_compose_interactive_roles) do |_host|
          within current_path do
            result = capture "cd #{current_path} && docker-compose #{cmd}"
          end
        end
      end
      result
    end

    def self.execute_local_or_remote_interactive(cmd)
      puts "runnig: docker-compose #{cmd}"
      if local_stage?
        system "docker-compose #{cmd}"
      else
        on roles fetch(:docker_compose_interactive_roles) do |host|
          run_interactively host do
            within current_path do
              execute "cd #{current_path} && docker-compose #{cmd}"
            end
          end
        end
      end
    end

  end
end
