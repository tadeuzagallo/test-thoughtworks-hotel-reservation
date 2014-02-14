require_relative '../models/reservation'

module HotelHelper
  def self.find_cheapest_hotel(customer_type, dates)
    helpers = hotels.map { |h| Reservation.new(h, customer_type, dates) }

    helpers.sort { |a, b| a.better?(b) ? -1 : 1 }.first.hotel
  end

  def self.register_hotel(hotel)
    hotels.include?(hotel) || hotels << hotel

    self
  end

  private

  def self.hotels
    @hotels ||= []
  end
end
