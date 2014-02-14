require_relative '../models/hotel'

class HotelHelper
  attr_accessor :hotel, :customer_type, :dates

  def initialize(hotel, customer_type, dates)
    self.hotel = hotel
    self.customer_type = customer_type
    self.dates = dates
  end

  def better?(another_helper)
    return true if total_price < another_helper.total_price

    hotel.better?(another_helper.hotel)
  end

  def self.find_cheapest_hotel(customer_type, dates)
    helpers = hotels.map { |h| HotelHelper.new(h, customer_type, dates) }

    helpers.sort { |a, b| a.better?(b) ? -1 : 1 }.first.hotel
  end

  def self.register_hotel(hotel)
    hotels.include?(hotel) || hotels << hotel

    self
  end

  def total_price
    @total_price ||= hotel.price_for_dates(customer_type, dates)
  end

  private

  def self.hotels
    @hotels ||= []
  end
end
