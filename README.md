# Capistrano::DockerCompose::Interactive [![Gem Version](https://badge.fury.io/rb/capistrano-dockercompose-interactive.svg)](https://badge.fury.io/rb/capistrano-dockercompose-interactive)

Helps managing docker compose excution on local or remote with inetractive shell support.

This project is in an early stage but helps me alot dealing with my container deployments and keeps my code clean. Feel free to contribute =)

This gem depends on [sshkit-interactive](https://github.com/afeld/sshkit-interactive).

## Installation

Add this line to your application's `Gemfile` (make sure you have installed ruby and bundler ;):

```ruby
gem 'capistrano-dockercompose-interactive'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-dockercompose-interactive

Dont forget to require the module in your Capfile:

```ruby
require 'capistrano/dockercompose/interactive'
```  

### Usage
    #TODO

## Changes

### Version 0.0.8
  * fix `isup?` boolean behaviour
  * add `DockerCompose::Interactive::Instance::count_container`

### Version 0.0.7
  * add `isup?`, `satrt`, `stop`, `restart`, `up`, `down`, `build`, `pull`, `start_or_restart` to `DockerCompose::Interactive::Instance`

### Version 0.0.2
  * use clean modiule namespaces

### Version 0.0.1
  * initial release

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
