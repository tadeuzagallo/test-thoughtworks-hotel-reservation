require 'date'

module DateParser
  def self.parse(date)
    Date.strptime(date, '%d%b%Y').to_time
  end
end
