require 'yaml'
require_relative './service'

module DockerCompose
  module Interactive
    class Instance
      def initialize(file='', project=nil)
        @file    = file
        @project = project
      end

      def config
        return @config if @config
        raw_config = execute_compose_command('config', true)
        @config = YAML.load(raw_config)
      end

      def execute(cmd, capture = false)
        execute_compose_command(cmd, capture)
      end

      def execute_compose_command(cmd, capture = false)
        project = @project.empty? ? "" : "-p #{@project}"
        file    = @file.empty?    ? "" : "--file #{@file}"
        cmd     = "#{file} #{project} #{cmd}"

        if capture
          return DockerCompose::Interactive.capture_local_or_remote cmd
        else
          DockerCompose::Interactive.execute_local_or_remote_interactive cmd
        end
      end

      def service(name)
        Service.new(self, name, config()['services'][name])
      end

      def isup?
        count = execute_compose_command('ps -q | wc -l', capture = true)
        count.to_i
      rescue
        false
      end

      # starts or restarts a docker compose
      def start_or_restart
        if isup?
          restart()
        else
          up()
        end
      end

      def stop(args='')
        execute_compose_command("stop #{args}")
      end

      def down(args='')
        execute_compose_command("down #{args}")
      end

      def up(args='-d')
        execute_compose_command("up #{args}")
      end

      def start(args='')
        execute_compose_command("start #{args}")
      end

      def restart(args='')
        execute_compose_command("restart #{args}")
      end

      def build(args='')
        execute_compose_command("build #{args}")
      end

      def pull(args='')
        execute_compose_command("pull #{args}")
      end
    end
  end
end
