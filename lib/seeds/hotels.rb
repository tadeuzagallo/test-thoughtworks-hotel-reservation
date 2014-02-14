#● Lakewood with a rating of 3 has weekday rates as 110$ for regular customer and 80$ for rewards customer. The weekend rates are 90$ for regular customer and 80$ for a rewards customer.
#● Bridgewood with a rating of 4 has weekday rates as 160$ for regular customer and 110$ for rewards customer. The weekend rates are 60$ for regular customer and 50$ for a rewards customer.
#● Ridgewood with a rating of 5 has weekday rates as 220$ for regular customer and 100$ for rewards customer. The weekend rates are 150$ for regular customer and 40$ for a rewards customer.

require_relative '../models/hotel'
require_relative '../helpers/hotel_helper'

HotelHelper.register_hotel(Hotel.new.tap do |h|
  h.name = 'Lakewood'
  h.rating = 3
  h.add_price(:regular, false, 110)
  h.add_price(:rewards, false,  80)
  h.add_price(:regular,  true,  90)
  h.add_price(:rewards,  true,  80)
end)

HotelHelper.register_hotel(Hotel.new.tap do |h|
  h.name = 'Bridgewood'
  h.rating = 4
  h.add_price(:regular, false, 160)
  h.add_price(:rewards, false, 110)
  h.add_price(:regular,  true,  60)
  h.add_price(:rewards,  true,  50)
end)

HotelHelper.register_hotel(Hotel.new.tap do |h|
  h.name = 'Ridgewood'
  h.rating = 5
  h.add_price(:regular, false, 220)
  h.add_price(:rewards, false, 100)
  h.add_price(:regular,  true, 150)
  h.add_price(:rewards,  true,  40)
end)
