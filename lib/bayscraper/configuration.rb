require 'singleton'

module Bayscraper
  class Configuration
    include Singleton
    attr_reader :config

    def initialize
      @config = {}
    end

    def update(config)
      @config = config
    end

    def app_id
      config['app_id']
    end
  end
end
