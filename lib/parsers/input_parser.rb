require_relative './date_parser'
require_relative '../helpers/customer_helper'

module InputParser
  INPUT_REGEXP = /\A(?<customer_type>\w+):\s+(?<dates>\w+.*)\n?\z/

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
