require 'spec_helper'
require 'reservation_helper'
require 'hotel'

describe ReservationHelper do
  let (:thursday) { Time.new(2014, 02, 13) }
  let (:input) { {customer_type: customer_type, dates: [thursday] } }

  let(:hotel) do
    Hotel.new.tap do |h|
      h.name = "Hotel #1"
      h.rating = 3
      h.add_price(@regular_customer, false, 100)
        .add_price(@regular_customer, true, 60)
        .add_price(@rewards_customer, false, 150)
        .add_price(@rewards_customer, true, 100)
    end
  end

  before(:each) do
    @regular_customer = :regular
    @rewards_customer = :rewards

    @expensive_hotel = Hotel.new
    @expensive_hotel.name = "Hotel #2"
    @expensive_hotel.rating = 5
    @expensive_hotel.add_price(@regular_customer, false, 200)
      .add_price(@regular_customer, true, 160)
      .add_price(@rewards_customer, false, 150)
      .add_price(@rewards_customer, true, 110)

    ReservationHelper.hotels = [@expensive_hotel]
  end

  it { should respond_to(:find_cheapest_hotel) }
  it { should respond_to(:register_hotel) }

  context '#find_cheapest_hotel' do
    it 'returns a hotel' do
      ReservationHelper.find_cheapest_hotel(@regular_customer, [thursday]).should be_a(Hotel)
    end

    it 'returns the only hotel' do
      ReservationHelper.find_cheapest_hotel(@regular_customer, [thursday]).should == @expensive_hotel
    end

    it 'returns the cheapest hotel' do
      ReservationHelper.register_hotel(hotel)
      ReservationHelper.find_cheapest_hotel(@regular_customer, [thursday]).should == hotel
    end
  end
end
