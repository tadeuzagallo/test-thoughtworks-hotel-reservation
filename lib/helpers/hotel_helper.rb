require_relative '../models/hotel'

module HotelHelper
  def self.find_cheapest_hotel(customer_type, dates)
    hotels.map do |hotel|
      {
        price: hotel.price_for_dates(customer_type, dates),
        hotel: hotel 
      }
    end.sort do |a, b|
      price_diff = a[:price] - b[:price]

      next price_diff unless price_diff.zero?

      b[:hotel].better?(a[:hotel]) ? 1 : -1
    end.first[:hotel]
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
