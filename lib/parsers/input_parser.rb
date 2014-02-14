require_relative './date_parser'
require_relative '../helpers/customer_helper'

module InputParser
  INPUT_REGEXP = %r{
      \A                    # Start of the input
      (?<customer_type>\w+) # Customer type
      :
      \s+
      (?<dates>\w+.*)       # Date
      \n?
      \z                    # End of the input
    }x

  def self.parse(input)
    valid?(input) || fail(ArgumentError, 'Invalid input')

    {
      customer_type: parsed_type,
      dates: parsed_dates
    }
  end

  def self.valid?(input)
    @last = INPUT_REGEXP.match(input)

    !@last.nil? && CustomerHelper.valid_type?(@last[:customer_type])
  end

  private

  def self.parsed_type
    CustomerHelper.normalize_type(@last[:customer_type])
  end

  def self.parsed_dates
    @last[:dates].split(', ').map { |date| DateParser.parse(date) }
  end
end
