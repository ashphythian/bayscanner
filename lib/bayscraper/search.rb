require 'nokogiri'
require 'pry'
require 'pry-rails'
require 'pry-byebug'
require 'awesome_print'

module Bayscraper
  class Search
    attr_reader :search_terms, :exclusions, :min_price, :max_price
    private :search_terms, :exclusions, :min_price, :max_price

    def initialize(search_terms, exclusions, min_price, max_price)
      @search_terms = search_terms
      @exclusions = exclusions
      @min_price = min_price
      @max_price = max_price
    end

    def self.search(search_terms, exclusions, min_price, max_price)
      new(search_terms, exclusions, min_price, max_price).search
    end

    def search
      if !items_within_price_range.empty?
        puts "The cheapest is £#{cheapest[:total_price]} (inc. postage).\n"
        puts "The link is #{cheapest[:link]}."
      else
        puts "There aren't any."
      end
    end

    private

    def cheapest
      items_within_price_range[0]
    end

    def scraping_success?
      prices.length == postages.length &&
        postages.length == links.length &&
        prices.length > 0
    end

    def ebay_url
      "http://www.ebay.co.uk/sch/?_nkw=#{search_terms} #{search_exclusions}&_sop=15&_udlo=#{min_price}&_udhi=#{max_price}"
    end

    def search_exclusions
      exclusions.split(' ').map { |e| '-' + e }.join(' ')
    end

    def page
      @page ||= Nokogiri::HTML(open(ebay_url))
    end

    def items
      page.css('div#Results ul#ListViewInner')
    end

    def prices_raw
      items.css('li.lvprice span.bold')
    end

    def postages_raw
      items.css('li.lvshipping span.ship')
    end

    def links_raw
      items.css('h3.lvtitle a')
    end

    def prices
      prices_raw.map do |x|
        x.children.text.strip.tr('Â','').split(' ')[0][/\d+\.?\d+/].to_f
      end
    end

    def postages
      postages_raw.map do |p|
        if ['Free', 'not specified'].any? { |postage| p.include?(postage) }
          0
        else
          p.children.text.strip.tr('Â','').split(' ')[1][/\d+\.?\d+/].to_f
        end
      end
    end

    def links
      links_raw.map { |l| l['href'] }
    end

    def total_prices
      [prices, postages].transpose.map { |x| x.reduce(:+).round(2) }
    end

    def items_zipped
      prices.zip(postages, total_prices, links)
    end

    def items_hashed
      items_zipped.map do |item|
        item = {
          price: item[0],
          postage: item[1],
          total_price: item[2],
          link: item[3]
        }
      end
    end

    def items_sorted
      items_hashed.sort_by { |hsh| hsh[:total_price] }
    end

    def items_within_price_range
      items_sorted.select do |price|
        price[:total_price].between?(min_price, max_price)
      end
    end
  end
end
