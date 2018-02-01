
namespace :dockercompose do
  namespace :interactive do
    
  end
end

namespace :load do
  task :defaults do
    set :local_stage_name, :local
    set :docker_compose_interactive_file, ''
    set :docker_compose_interactive_project, ''
    set :docker_compose_interactive_roles, :container_host
  end
end
