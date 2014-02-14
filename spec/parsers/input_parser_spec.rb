require_relative '../spec_helper'
require_relative '../../lib/parsers/input_parser'
require_relative '../../lib/helpers/customer_helper'

describe InputParser do
  it { should respond_to(:parse) }
  it { should respond_to(:valid?) }

  let (:valid_input) { 'Rewards: 26Mar2009(thur)' }
  let (:input_without_date) { 'Rewards: ' }
  let (:input_invalid_type) { 'Reward: 26Mar2009(thur)' }

  before(:all) do
    CustomerHelper.register_type('Regular')
    CustomerHelper.register_type('Rewards')
  end

  context '#valid?' do
    it 'returs true for valid input' do
      InputParser.valid?(valid_input).should be_true
    end

    it 'returns false for nil' do
      InputParser.valid?(nil).should be_false
    end

    it 'returns false if no date is given' do
      InputParser.valid?(input_without_date).should be_false
    end

    it 'returns false if customer type is invalid' do
      InputParser.valid?(input_invalid_type).should be_false
    end
  end

  context '#parse' do
    it 'raises on empty input' do
      expect { InputParser.parse(nil) }.to raise_error
    end

    it 'returns hash from valid input' do
      InputParser.parse(valid_input).should be_a(Hash)
    end

    it 'returns normalized customer type' do
      InputParser.parse(valid_input).should include(customer_type: :rewards)
    end

    it 'returns an array of dates' do
      time = Time.now
      
      DateParser.should_receive(:parse).and_return(time)
      
      InputParser.parse(valid_input).should include(
        dates: [ time ]
      )
    end
  end
end
