require 'sinatra'
require 'bundler'
Bundler.require

require 'rack/test'
Dir.glob('./presenters/*.rb') { |f| require f }
require './tarot_app'
require 'minitest/autorun'

class TarotSpec < Minitest::Spec

end
