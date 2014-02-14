require_relative '../models/hotel'
require_relative '../helpers/hotel_helper'

HotelHelper.register_hotel(Hotel.new.tap do |h|
  h.name = 'Lakewood'
  h.rating = 3
  h.set_price(:regular, false, 110)
  h.set_price(:rewards, false,  80)
  h.set_price(:regular,  true,  90)
  h.set_price(:rewards,  true,  80)
end)

HotelHelper.register_hotel(Hotel.new.tap do |h|
  h.name = 'Bridgewood'
  h.rating = 4
  h.set_price(:regular, false, 160)
  h.set_price(:rewards, false, 110)
  h.set_price(:regular,  true,  60)
  h.set_price(:rewards,  true,  50)
end)

HotelHelper.register_hotel(Hotel.new.tap do |h|
  h.name = 'Ridgewood'
  h.rating = 5
  h.set_price(:regular, false, 220)
  h.set_price(:rewards, false, 100)
  h.set_price(:regular,  true, 150)
  h.set_price(:rewards,  true,  40)
end)
