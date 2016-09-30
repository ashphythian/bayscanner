require 'spec_helper'

module Bayscraper
  describe Search do
    subject { Bayscraper::Search.new(search_terms, exclusions, min_price, max_price).search }

    let(:search_terms) { 'zvex instant junky' }
    let(:exclusions) { 'power' }
    let(:min_price) { 0 }
    let(:max_price) { 250 }

    describe '#search' do
      context 'There are search results' do
        it 'returns the cheapest' do
          expect(subject).to eql('hello')
          subject
        end
      end

      context 'There are no search results' do
        # it { is_expected.to eql("There aren't any") }
        # subject
      end
    end
  end
end
