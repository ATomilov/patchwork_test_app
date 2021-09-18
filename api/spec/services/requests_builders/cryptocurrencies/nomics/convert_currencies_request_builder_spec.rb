# frozen_string_literal: true

require 'rails_helper'

describe ::RequestsBuilders::Cryptocurrencies::Nomics::ConvertCurrenciesRequestBuilder do
  let(:expected_url) { 'https://api.nomics.com/v1/currencies/ticker' }
  let(:expected_request_type) { 'get' }
  let(:expected_api_key) { 'test-key' }

  let(:source_currency) { 'test' }
  let(:target_currency) { 'target test' }

  subject do
    described_class.new(
      source_currency: source_currency,
      target_currency: target_currency
    )
  end

  describe '#url' do
    context 'when the all params are present' do
      it 'returns the url value' do
        expect(subject.url).to eq(expected_url)
      end
    end
  end

  describe '#request_method' do
    context 'when the all params are present' do
      it 'returns the request_method value' do
        expect(subject.request_method).to eq(expected_request_type)
      end
    end
  end

  describe '#options' do
    context 'when the all params are present' do
      it 'returns the options to request', :aggregate_failures do
        expect(subject.options.dig(*%i[query ids])).to eq(source_currency)
        expect(subject.options.dig(*%i[query convert])).to eq(target_currency)
      end
    end
  end
end
