require 'yaml'

module DockerCompose::Interactive
  def DockerCompose.instance(file='', project='')
    Instance.new(file, project)
  end

  def DockerCompose.local_stage?
    fetch(:local_stage_name, 'local').to_sym == fetch(:stage).to_sym
  end

  def DockerCompose.capture_local_or_remote(cmd)
    puts "runnig: docker-compose #{cmd}"
    result = ''
    if local_stage?
      run_locally do
        result = capture "docker-compose #{cmd}"
      end
    else
      on roles :container_host do |_host|
        within current_path do
          result = capture "cd #{current_path} && docker-compose #{cmd}"
        end
      end
    end
    result
  end

  def DockerCompose.execute_local_or_remote_interactive(cmd)
    puts "runnig: docker-compose #{cmd}"
    if local_stage?
      run_locally do
        execute "docker-compose #{cmd}"
      end
    else
      on roles :container_host do |_host|
        run_interactively _host do
          within current_path do
            execute "cd #{current_path} && docker-compose #{cmd}"
          end
        end
      end
    end
  end

  class Instance
    def initialize(file='', project=nil)
      @file    = file
      @project = project
    end

    def config
      return @config if @config
      raw_config = execute('config', true)
      @config = YAML.load(raw_config)
    end

    def execute_compose_command(cmd, capture = false)
      project = @project.empty? ? "" : "-p #{@project}"
      file    = @file.empty?    ? "" : "--file #{@file}"
      cmd     = "#{file} #{project} #{cmd}"

      if capture
        return DockerCompose.capture_local_or_remote cmd
      else
        DockerCompose.execute_local_or_remote_interactive cmd
      end
    end

    def service(name)
      Service.new(self, name, config()['services'][name])
    end
  end

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
