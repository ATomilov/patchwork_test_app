require 'rails_helper'

describe ::RequestsBuilders::Cryptocurrencies::Nomics::GetListRequestBuilder do
  let(:expected_url) { 'https://api.nomics.com/v1/currencies/ticker' }
  let(:expected_request_type) { 'get' }
  let(:expected_api_key) { 'test-key' }

  let(:currencies) { %w[test1 test2 test3] }
  let(:ids_for_request) { 'test1,test2,test3' }
  let(:per_page) { 50 }
  let(:page_number) { 2 }

  let(:default_per_page) { 100 }
  let(:default_page_number) { 1 }

  subject(:builder_with_all_params) do
    described_class.new(
      currencies: currencies,
      per_page: per_page,
      page_number: page_number
    )
  end

  subject(:builder_with_currencies_only) do
    described_class.new(
      currencies: currencies
    )
  end

  describe '#url' do
    context 'when the all params are present' do
      it 'returns the url value' do
        expect(builder_with_all_params.url).to eq(expected_url)
      end
    end
  end

  describe '#request_method' do
    context 'when the all params are present' do
      it 'returns the request_method value' do
        expect(builder_with_all_params.request_method).to eq(expected_request_type)
      end
    end
  end

  describe '#options' do
    context 'when the all params are present' do
      it 'returns the options to request', :aggregate_failures do
        expect(builder_with_all_params.options.dig(*%i[query ids])).to eq(ids_for_request)
        expect(builder_with_all_params.options.dig(*%i[query key])).to eq(expected_api_key)
        expect(builder_with_all_params.options.dig(:query, 'per-page')).to eq(per_page)
        expect(builder_with_all_params.options.dig(*%i[query page])).to eq(page_number)
      end
    end

    context 'when the incoming params does not contain the per_page and page_number options' do
      it 'returns the default values', :aggregate_failures do
        expect(builder_with_currencies_only.options.dig(:query, 'per-page')).to eq(default_per_page)
        expect(builder_with_currencies_only.options.dig(*%i[query page])).to eq(default_page_number)
      end
    end
  end
end
