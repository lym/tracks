ENV["RAILS_ENV"] ||= "test"
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/setup'

$:.unshift File.dirname(File.dirname(__FILE__))
