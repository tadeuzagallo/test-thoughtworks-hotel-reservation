require 'date_parser'

module InputParser
  def self.parse(input)
    valid?(input) || fail(ArgumentError, 'Invalid input')

    {
      customer_type: @last[:customer_type],
      dates: parsed_dates
    }
  end

  def self.valid?(input)
    @last = regexp.match(input)

    !@last.nil?
  end

  private

  def self.regexp
    @regexp ||= %r{
      \A                    # Start of the input
      (?<customer_type>\w+) # Customer type
      :
      \s+
      (?<dates>\w+.*)       # Date
      \z                    # End of the input
    }x
  end

  def self.parsed_dates
    @last[:dates].split(', ').map { |date| DateParser.parse(date) }
  end
end
