require 'spec_helper'

module Bayscraper
  describe Search do
    let(:exclusions) { 'power' }
    let(:min_price) { 100 }
    let(:max_price) { 150 }
    let(:url) { "http://www.ebay.co.uk/sch/?_nkw=#{search_terms} #{exclusions}&"\
                "_sop=15&_udlo=#{min_price}&_udhi=#{max_price}" }

    describe '#search' do
      context 'There are search results' do
        subject do
          VCR.use_cassette('scraping_results') do
            Bayscraper::Search.new(
              search_terms,
              exclusions,
              min_price,
              max_price).search
          end
        end

        let(:search_terms) { 'zvex instant junky' }

        it 'returns an array' do
          expect(subject.class).to eql(Array)
        end

        it 'contains hashes of item information' do
          subject.each do |sub|
            expect(sub).to include(
              :title,
              :total_price,
              :price,
              :postage,
              :link,
              :image,
            )
          end
        end
      end

      context 'There are no search results' do
        subject do
          VCR.use_cassette('empty_scraping_results') do
            Bayscraper::Search.new(
              search_terms,
              exclusions, 
              min_price,
              max_price).search
          end
        end

        let(:search_terms) { 'Proven Homeopathic Recipes' }

        it 'returns an empty array' do
          expect(subject).to eql([])
        end
      end
    end
  end
end
