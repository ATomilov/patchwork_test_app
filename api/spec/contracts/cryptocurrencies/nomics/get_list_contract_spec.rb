require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe ::Cryptocurrencies::Nomics::GetListContract do
  let(:described_class_object) { described_class.new }

  let(:valid_incoming_params) do
    {
      currencies: %w[test1 test2 test3],
      per_page: '50',
      page_number: '2',
      display_fields: %w[test1 test2 test3],
      broker_currency: 'test'
    }
  end

  let(:valid_incoming_params_without_pagination) do
    {
      currencies: %w[test1 test2 test3]
    }
  end

  let(:all_invalid_params) do
    {
      currencies: ['', 1, nil],
      per_page: 30,
      page_number: 1,
      display_fields: ['', 1, nil],
      broker_currency: nil
    }
  end

  describe '#call' do
    context 'when the all incoming params are valid' do
      it_behaves_like 'passed validation' do
        let(:validation_params) { valid_incoming_params }
      end

      it_behaves_like 'passed validation' do
        let(:validation_params) { valid_incoming_params_without_pagination }
      end
    end

    context 'when a specific param is invalid' do
      let(:validation_params) { valid_incoming_params }

      context 'and when the currencies param is invalid' do
        let(:param) { :currencies }

        [
          ['', ' ', nil, 1],
          [nil, nil],
          [12, 12]
        ].each do |value|
          it_behaves_like 'failed validation with a specific attribute' do
            let(:value) { value }
          end
        end
      end

      context 'and when the per_page param is invalid' do
        let(:param) { :per_page }

        ['', ' ', 1, 100, '1test', '1test1'].each do |value|
          it_behaves_like 'failed validation with a specific attribute' do
            let(:value) { value }
          end
        end
      end

      context 'and when the page_number param is invalid' do
        let(:param) { :page_number }

        ['', ' ', 1, 100, '1test', '1test1', '0'].each do |value|
          it_behaves_like 'failed validation with a specific attribute' do
            let(:value) { value }
          end
        end
      end

      context 'and when the display_fields param is invalid' do
        let(:param) { :display_fields }

        [
          ['', ' ', nil, 1],
          [nil, nil],
          [12, 12]
        ].each do |value|
          it_behaves_like 'failed validation with a specific attribute' do
            let(:value) { value }
          end
        end
      end

      context 'and when the broker_currency param is invalid' do
        let(:param) { :broker_currency }

        ['', ' ', 1, 100, ' 1test', ' 1test1 ', ' 0 asdf asdf', nil].each do |value|
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
