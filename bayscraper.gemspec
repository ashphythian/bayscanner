# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bayscraper/version'

Gem::Specification.new do |spec|
  spec.name          = "bayscraper"
  spec.version       = Bayscraper::VERSION
  spec.authors       = ["Ash Phythian"]
  spec.email         = ["ashley.phythian@gmail.com"]

  spec.summary       = "This gem scrapes ebay for the cheapest item given a description"
  spec.description   = "To be used for obscure items which are rarely cheap"
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.add_runtime_dependency 'nokogiri'
  # spec.add_runtime_dependency 'open-uri'
  # spec.add_runtime_dependency 'money'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  # spec.add_development_dependency 'pry'
  # spec.add_development_dependency 'awesome-print'

  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'httparty'
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'webmock'
  spec.add_runtime_dependency 'vcr'
end
