require 'bayscraper/all'

module Bayscraper
  extend Forwardable
  extend self

  def_delegators Bayscraper::Search, :search
end
