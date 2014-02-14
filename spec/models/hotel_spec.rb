require_relative '../spec_helper'
require_relative '../../lib/models/hotel'

describe Hotel do
  let (:regular_customer) { :regular }
  let (:rewards_customer) { :rewards }

  let (:regular_week_value) { 100 }
  let (:regular_weekend_value) { 60 }

  let (:rewards_week_value) { 100 }
  let (:rewards_weekend_value) { 60 }

  let (:monday) { Time.new(2014, 02, 10) }
  let (:sunday) { Time.new(2014, 02, 9) }

  let(:hotel) { Hotel.new }

  let(:full_hotel) do
    Hotel.new.tap do |hotel|
      hotel.add_price(rewards_customer, true, rewards_weekend_value)
        .add_price(rewards_customer, false, regular_week_value)
        .add_price(regular_customer, true, regular_weekend_value)
        .add_price(regular_customer, false, regular_week_value)
    end
  end

  it { should respond_to(:name) }
  it { should respond_to(:rating) }
  it { should respond_to(:price) }
  it { should respond_to(:add_price) }

  context '#add_price' do
    it 'adds a price' do
      expect {
        hotel.add_price(regular_customer, true, regular_weekend_value)
      }.to change { hotel.send(:prices).size }.by(1)

      expect {
        hotel.add_price(regular_customer, false, regular_week_value)
      }.to change { hotel.send(:prices)[regular_customer].size }.by(1)
    end

    it 'updates a price' do
      hotel.add_price(regular_customer, true, regular_weekend_value)

      new_value = 132

      expect {
        hotel.add_price(regular_customer, true, new_value)
      }.to_not change { hotel.send(:prices).size }

      hotel.price(regular_customer, sunday).should == new_value
    end
  end

  context '#price' do
    it 'finds regular week price' do
      full_hotel.price(regular_customer, monday).should == regular_week_value
    end

    it 'finds regular weekend price' do
      full_hotel.price(regular_customer, sunday).should == regular_weekend_value
    end

    it 'finds rewards weekend price' do
      full_hotel.price(rewards_customer, monday).should == rewards_week_value
    end

    it 'finds rewards weekend price' do
      full_hotel.price(rewards_customer, sunday).should == rewards_weekend_value
    end
  end
end
