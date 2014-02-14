require_relative '../models/hotel'

module HotelHelper
  def self.find_cheapest_hotel(customer_type, dates)
    min = nil
    cheapest = nil

    hotels.each_with_index do |hotel, index|
      total = hotel.price_for_dates(customer_type, dates)

      if min.nil? || total < min || total == min && hotel.better?(cheapest)
        min = total
        cheapest = hotel
      end
    end

    cheapest
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
