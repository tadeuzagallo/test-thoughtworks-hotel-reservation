require_relative '../spec_helper'
require_relative '../../lib/models/hotel'
require_relative '../../lib/helpers/hotel_helper'

module HotelHelper 
  def self.clear
    @hotels = []
  end
end

describe HotelHelper do
  let (:hotel) { Hotel.new }

  before { HotelHelper.clear }

  it { should respond_to(:find_cheapest_hotel) }
  it { should respond_to(:register_hotel) }

  context '#register_hotel' do
    it 'adds a new hotel' do
      expect {
        HotelHelper.register_hotel(hotel)
      }.to change { HotelHelper.hotels.size }.by(1)
    end

    it 'does not add the same hotel twice' do
      HotelHelper.register_hotel(hotel)

      expect {
        HotelHelper.register_hotel(hotel)
      }.not_to change { HotelHelper.send(:hotels).size }
    end
  end

  context '#find_cheapest_hotel' do
    it 'uses reservation to decide the best hotel' do
      cheap = double(:reservation, better?: true, hotel: hotel)
      expensive = double(:reservation)

      Reservation.should_receive(:new)
        .exactly(2).times
        .and_return(cheap, expensive)

      HotelHelper.register_hotel(1).register_hotel(2)

      HotelHelper.find_cheapest_hotel(:regular, []).should == cheap.hotel
    end
  end
end
