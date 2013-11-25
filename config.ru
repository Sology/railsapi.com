$:.unshift ::File.expand_path(::File.join(::File.dirname(__FILE__), 'lib/'))
require 'rubygems'
require 'bundler'
Bundler.require

set :run => false
set :environment => ENV['environment'] || :development
set :app_file => 'sdoc-site.rb'

require './sdoc_app.rb'

run Sinatra::Application
