require 'bayscraper/all.rb'

module Bayscraper
  extend Forwardable
  extend self

  def_delegators Bayscraper::Search, :search
end
