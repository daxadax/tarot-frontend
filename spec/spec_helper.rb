require 'sinatra'
require 'bundler'
Bundler.require

require 'rack/test'
require './presenters'
require './tarot_app'
require 'minitest/autorun'

class TarotSpec < Minitest::Spec

end
