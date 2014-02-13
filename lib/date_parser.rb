module DateParser
  def self.parse(date)
    Date.strptime(date, '%d%b%Y(%a)').to_time
  end
end
