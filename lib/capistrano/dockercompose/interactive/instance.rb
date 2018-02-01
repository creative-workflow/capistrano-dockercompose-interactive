require 'yaml'
require_relative './service'


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
end
