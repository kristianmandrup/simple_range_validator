require 'spec_helper'

# http://jeffkreeftmeijer.com/2011/isolated-testing-for-custom-validators-in-rails-3/

class ValidatableRange
  include ActiveModel::Validations

  validates :cost, range: {within: 0..2000}
end

describe RangeValidator do

  subject { ValidatableRange.new }

  context 'with a cost range that is not too expensive' do

    before { subject.stub(:cost).and_return (0..100) }

    it { should be_valid }
  end

  context 'with a cost range that is WAY too expensive' do

    before { subject.stub(:cost).and_return (0..50000) }

    it { should_not be_valid }
  end
end
