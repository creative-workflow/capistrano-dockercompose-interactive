
module DockerCompose
  module Interactive
    class Service
      def initialize(compose, name, config)
        @compose, @name, @config = compose, name, config
      end

      def id
        result = @compose.execute_compose_command("ps -q #{@name}", true)
        result.split(';').shift.strip
      end

      def exec(cmd, capture=false)
        cmd = "exec #{@name} #{cmd}"
        @compose.execute_compose_command(cmd, capture)
      end

      def run(cmd, capture=false, args="--rm")
        cmd = "run #{args} #{@name} #{cmd}"
        @compose.execute_compose_command(cmd, capture)
      end
    end
  end
end
