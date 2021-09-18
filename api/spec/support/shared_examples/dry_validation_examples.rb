shared_examples 'failed validation' do
  it 'returns a failure result' do
    expect(described_class_object.call(validation_params)).to be_failure
  end
end

shared_examples 'failed validation with a specific attribute' do
  it 'returns a failure result' do
    expect(described_class_object.call(validation_params.merge(param => value))).to be_failure
  end
end

shared_examples 'passed validation' do
  it 'returns a success result' do
    expect(described_class_object.call(validation_params)).to be_success
  end
end
