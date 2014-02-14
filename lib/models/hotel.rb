class Hotel
  attr_accessor :name, :rating

  def add_price(customer_type, weekend, value)
    prices[customer_type] ||= {}

    prices[customer_type][weekend] = value
    self
  end

  def price(customer_type, date)
    prices[customer_type][date.saturday? || date.sunday?]
  end

  def better?(other)
    rating > other.rating
  end

  private

  def prices
    @prices ||= {}
  end
end
