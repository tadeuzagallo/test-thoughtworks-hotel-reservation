require_relative '../spec_helper'
require_relative '../../lib/parsers/date_parser'

describe DateParser do
  it { should respond_to(:parse) }

  context '#parse' do
    it 'raises an error for invalid entry' do
      expect { DateParser.parse(nil) }.to raise_error 
    end

    it 'raises an error for invalid format' do
      expect { DateParser.parse('03/27/2009') }.to raise_error
    end

    it 'raises an error for invalid data' do
      expect { DateParser.parse('32Mar2009(fri)') }.to raise_error
    end

    it 'parses simple date' do
      time = DateParser.parse('27Mar2009')

      time.day.should == 27
      time.month.should == 3
      time.year.should == 2009
      time.wday.should == 5
    end

    it 'parses full date' do
      time = DateParser.parse('27Mar2009(fri)')

      time.day.should == 27
      time.month.should == 3
      time.year.should == 2009
      time.wday.should == 5
    end
  end
end
