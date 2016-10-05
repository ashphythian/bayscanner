require 'spec_helper'

module Bayscraper
  describe Search do
    subject { Bayscraper::Search.new(search_terms, search_exclusions, min_price, max_price).search }

    let(:search_terms) { 'zvex instant junky' }
    let(:search_exclusions) { 'power' }
    let(:min_price) { 0 }
    let(:max_price) { 250 }
    let(:url) { "http://www.ebay.co.uk/sch/?_nkw=#{search_terms} #{search_exclusions}&_sop=15&_udlo=#{min_price}&_udhi=#{max_price}" }

    describe '#search' do
      context 'There are search results' do
        it 'returns a hash' do
          VCR.use_cassette('scraping_results') do
            expect(subject).to include(
              :title,
              :total_price,
              :price,
              :postage,
              :link,
              :image,
            )
            subject
          end
        end
      end

      context 'There are no search results' do
        let(:search_terms) { 'thisproductsurelydoesnotexist' }

        it 'returns an empty hash' do
          VCR.use_cassette('empty_scraping_results') do
            expect(subject).to be_nil
          end
        end
      end
    end
  end
end
