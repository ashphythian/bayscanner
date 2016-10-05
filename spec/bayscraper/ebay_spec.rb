require 'spec_helper'
require 'vcr'
require 'pry'
require 'yaml'

module Bayscraper
  describe Ebay do
    # subject { Bayscraper::Ebay.new(search_terms).price_order }

    let(:search_terms) { 'zvex instant junky -power' }
    let(:app_id) { 'hello' }
    let(:body) { [ { item: 'item' } ] }
    let(:ok_response) { double('Net') }
    let(:config) { YAML.load_file('config/application.yml') }
    let(:app_id) { config['app_id'] }

    let(:ebay_uri) {
      "http://svcs.ebay.com/services/search/FindingService/v1?"\
      'GLOBAL-ID=EBAY-GB&OPERATION-NAME=findItemsByKeywords&'\
      'RESPONSE-DATA-FORMAT=XML&REST-PAYLOADpaginationInput.entriesPerPage=6&'\
      "SECURITY-APPNAME=#{app_id}&"\
      'SERVICE-VERSION=1.0.0&keywords=zvex%20instant%20junky%20-power&siteid=3'\
    }
    let(:ebay_uri_no_results) {
      "http://svcs.ebay.com/services/search/FindingService/v1?"\
      'GLOBAL-ID=EBAY-GB&OPERATION-NAME=findItemsByKeywords&'\
      'RESPONSE-DATA-FORMAT=XML&REST-PAYLOADpaginationInput.entriesPerPage=6&'\
      "SECURITY-APPNAME=#{app_id}&"\
      'SERVICE-VERSION=1.0.0&keywords=akasdhasjkdhasjkdhasdjkashd&siteid=3'\
    }

    describe 'HTTParty' do
      context 'the http request returns items' do
        subject do
          VCR.use_cassette('ebay') do
            response = Net::HTTP.get_response(URI(ebay_uri))
          end
        end

        it 'returns an OK response' do
          # binding.pry
          expect(subject.code).to eql('200')
        end

        it 'has content' do
          expect(subject.body).to_not be_empty
        end
      end

      context 'the http request returns no items' do
        subject do
          VCR.use_cassette('ebay_no_results') do
            response = Net::HTTP.get_response(URI(ebay_uri_no_results))
          end
        end

        it 'returns an OK response' do
          expect(subject.code).to eql('200')
        end

        it 'has no content' do
          expect(subject.body).to include('count="0"')
        end
      end
    end
  end
end
