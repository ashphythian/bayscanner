$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bayscraper'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |vcr|
  vcr.cassette_library_dir=   'spec/fixtures/cassettes'
  vcr.hook_into               :webmock
  vcr.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
end
