require_relative '../../lib/models/hotel'
require_relative '../../lib/models/reservation'

describe Reservation do
  let (:customer_type) { :regular }

  subject { Reservation.new(Hotel.new, customer_type, []) }

  it { should respond_to(:hotel) }
  it { should respond_to(:customer_type) }
  it { should respond_to(:dates) }
  it { should respond_to(:better?) }
  it { should respond_to(:total_price) }

  context '#better?' do
    it 'returns the cheapest hotel' do
      cheap = double('hotel', price_for_dates: 50)
      expensive = double('hotel', price_for_dates: 200)

      Reservation.new(cheap, customer_type, [])
        .better?(Reservation.new(expensive, customer_type, [])).should be_true
    end

    it 'returns false without call #better? when more expensive' do
      cheap = double('hotel', price_for_dates: 50)
      expensive = double('hotel', price_for_dates: 200)

      expensive.should_not_receive(:better?)

      Reservation.new(expensive, customer_type, [])
        .better?(Reservation.new(cheap, customer_type, [])).should be_false
    end

    it 'calls hotel#better? on ties' do
      hotel = double('hotel', price_for_dates: 200)
      hotel.should_receive(:better?).exactly(1).times

      reservation = Reservation.new(hotel, customer_type, [])

      reservation.better?(reservation).should be_false
    end
  end

  context '#total_price' do
    it 'returns hotel price' do
      hotel = double('hotel', price_for_dates: 100)

      Reservation.new(hotel, customer_type, []).total_price.should == 100
    end
  end
end
