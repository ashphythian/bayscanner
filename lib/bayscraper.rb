require 'bayscraper/all'

module Bayscraper
  extend Forwardable
  extend self

  def_delegators Bayscraper::Search, :search
  def_delegators Bayscraper::Ebay, :price_order
end
