class Reservation
  attr_accessor :hotel, :customer_type, :dates

  def initialize(hotel, customer_type, dates)
    self.hotel = hotel
    self.customer_type = customer_type
    self.dates = dates
  end

  def better?(other_reservation)
    diff = total_price - other_reservation.total_price

    case
    when diff < 0
      true
    when diff.zero?
      hotel.better?(other_reservation.hotel)
    else
      false
    end
  end

  def total_price
    @total_price ||= hotel.price_for_dates(customer_type, dates)
  end
end
