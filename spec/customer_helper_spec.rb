require 'spec_helper'
require 'customer_helper'

describe CustomerHelper do
  it { should respond_to(:normalize_type) }
  it { should respond_to(:valid_type?) }
  it { should respond_to(:register_type) }

  context '#register_type' do 
    it 'puts a new type into stack' do
      expect { CustomerHelper.register_type('AnotherType') }.to change { CustomerHelper.types.size }.by(1)
    end

    it 'doesn\'t add same type twice' do
      type = 'NewType'

      CustomerHelper.register_type(type)
      expect { CustomerHelper.register_type(type) }.not_to change { CustomerHelper.types.size }
    end
  end

  context '#normalize_type' do
    it  { CustomerHelper.normalize_type('SomeType').should == :sometype }

  end

  context '#valid_type?' do
    it 'returns false to unregistered type' do
      CustomerHelper.valid_type?('SomeType').should be_false
    end

    it 'returns true after register' do
      CustomerHelper.register_type('SomeType2')
      CustomerHelper.valid_type?('SomeType2').should be_true
    end
  end
end
