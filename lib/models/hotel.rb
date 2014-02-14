class Hotel
  attr_accessor :name, :rating

  def set_price(customer_type, weekend, value)
    prices[customer_type] ||= {}

    prices[customer_type][weekend] = value
    self
  end

  def price_for_date(customer_type, date)
    prices[customer_type][date.saturday? || date.sunday?]
  end

  def price_for_dates(customer_type, dates)
    dates.map { |date| price_for_date(customer_type, date) }.reduce(&:+)
  end

  def better?(other)
    rating > other.rating
  end

  private

  def prices
    @prices ||= {}
  end
end
