require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe ::Cryptocurrencies::Nomics::ConvertCurrenciesContract do
  let(:described_class_object) { described_class.new }

  let(:valid_incoming_params) do
    {
      source_currency: 'test',
      target_currency: 'test2'
    }
  end

  let(:all_invalid_params) do
    {
      source_currency: nil,
      target_currency: nil
    }
  end

  describe '#call' do
    context 'when the all incoming params are valid' do
      it_behaves_like 'passed validation' do
        let(:validation_params) { valid_incoming_params }
      end
    end

    context 'when a specific param is invalid' do
      let(:validation_params) { valid_incoming_params }

      context 'and when the source_currency param is invalid' do
        let(:param) { :source_currency }

        ['', ' ', ' 123 ', ' 12 12 12 ', '123 ', nil, 123].each do |value|
          it_behaves_like 'failed validation with a specific attribute' do
            let(:value) { value }
          end
        end
      end

      context 'and when the target_currency param is invalid' do
        let(:param) { :target_currency }

        ['', ' ', ' 123 ', ' 12 12 12 ', '123 ', nil, 123].each do |value|
          it_behaves_like 'failed validation with a specific attribute' do
            let(:value) { value }
          end
        end
      end
    end

    context 'when the all incoming params are invalid' do
      it_behaves_like 'failed validation' do
        let(:validation_params) { all_invalid_params }
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
