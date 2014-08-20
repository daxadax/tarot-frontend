require 'rubygems'
require 'bundler/setup'
require 'tarot'
require 'sass/plugin/rack'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

Bundler.require

require './tarot_app'
require './lib/badges.rb'

run TarotApp