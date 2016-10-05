require 'httparty'
require 'pry'
require 'json'
require 'yaml'

module Bayscraper
  class Ebay
    include HTTParty
    attr_reader :keywords

    base_uri 'http://svcs.ebay.com'

    def initialize(keywords)
      @keywords = { query: { keywords: keywords } }
    end

    def self.price_order(keywords)
      new(keywords).price_order
    end

    def price_order
      formatted_results.sort_by { |x| x[:total_price] }
    end

    def formatted_results
      items.map do |item|
        item = {
          title: title(item),
          total_price: total_price(item).round(2),
          link: link(item),
          image: image(item),
          end_time: end_time(item),
          current_price: current_price(item),
          shipping_cost: shipping_cost(item)
        }
      end
    end

    def title(item)
      item['title']
    end

    def total_price(item)
      current_price(item) + shipping_cost(item)
    end

    def current_price(item)
      item['sellingStatus']['convertedCurrentPrice']['__content__'].to_f
    end

    def shipping_cost(item)
      item['shippingInfo']['shippingServiceCost']['__content__'].to_f
    end

    def link(item)
      item['viewItemURL']
    end

    def image(item)
      item['galleryUrl']
    end

    def end_time(item)
      item['listingInfo']['endTime']
    end

    def items
      results['findItemsByKeywordsResponse']['searchResult']['item']
    end

    def results
      self.class.get(path, keywords)
    end

    def path
      finding_service + rest_of_url
    end

    def finding_service
      '/services/search/FindingService/v1'
    end

    def rest_of_url
      "?SECURITY-APPNAME=#{app_id}&OPERATION-NAME=findItemsByKeywords&"\
      'SERVICE-VERSION=1.0.0&RESPONSE-DATA-FORMAT=XML&REST-PAYLOAD'\
      'paginationInput.entriesPerPage=6&GLOBAL-ID=EBAY-GB&siteid=3'
    end

    def app_id
      config['app_id']
    end

    def config
      YAML.load_file('config/application.yml')
    end
  end
end
