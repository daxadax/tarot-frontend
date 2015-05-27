require 'rubygems'
require 'bundler/setup'
require 'tarot'
require 'sass/plugin/rack'
require 'sass'
require 'json'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

Bundler.require

require './tarot_app'
Dir.glob('./lib/*.rb') { |f| require f }
Dir.glob('./presenters/*.rb') { |f| require f }

run TarotApp
