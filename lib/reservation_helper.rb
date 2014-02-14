require_relative './hotel'

module ReservationHelper
  def self.find_cheapest_hotel(customer_type, dates)
    min = 0
    min_index = -1

    hotels.each_with_index do |hotel, index|
      total =
        dates.map do |date|
          hotel.price(customer_type, date)
        end.reduce(&:+)

      if total < min
        min_index = index
      end
    end

    hotels[min_index]
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
