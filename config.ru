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
require './presenters/moon_presenter'

run TarotApp
