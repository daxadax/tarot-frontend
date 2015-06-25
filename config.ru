require 'rubygems'
require 'bundler/setup'
require 'tarot'
require 'sass/plugin/rack'
require 'sass'
require 'json'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

Bundler.require

Dir.glob('./lib/*.rb') { |f| require f }
require './presenters'
require './tarot_app'

run TarotApp
