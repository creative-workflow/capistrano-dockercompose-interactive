# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name        = 'capistrano-dockercompose-interactive'
  spec.version     = '0.0.6'
  spec.date        = '2018-02-03'
  spec.summary     = 'Helps managing docker compose excution on local or remote with inetractive shell support'
  spec.description = spec.summary
  spec.authors     = ['Tom Hanoldt']
  spec.email       = ['tom@creative-workflow.berlin']
  spec.homepage    = 'https://github.com/creative-workflow/capistrano-dockercompose-interactive'
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '>= 3.0.0'
  spec.add_dependency 'sshkit-interactive', '>= 0.2.3'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.1'
end
