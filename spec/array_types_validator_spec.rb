require 'spec_helper'

# http://jeffkreeftmeijer.com/2011/isolated-testing-for-custom-validators-in-rails-3/

class ValidatableType
  include ActiveModel::Validations

  validates :type, array_types: {only: [String, Fixnum]}
end

describe ArrayTypesValidator do

  subject { ValidatableType.new }

  context 'with a type with no values' do
    before { subject.stub(:type).and_return [] }

    it { should be_valid }
  end

  context 'with a type with a single valid value' do
    before { subject.stub(:type).and_return ['apartment'] }

    it { should be_valid }
  end

  context 'with a type with all valid values' do
    before { subject.stub(:type).and_return ['apartment', 27] }

    it { should be_valid }
  end

  context 'with a type with some invalid values' do
    before { subject.stub(:type).and_return ['apartment', :boat] }

    it { should_not be_valid }
  end

  context 'with a type that is not an Array' do
    before { subject.stub(:type).and_return 'apartment' }

    specify {
      expect { subject.valid? }.to raise_error(ArgumentError)
    }
  end
end