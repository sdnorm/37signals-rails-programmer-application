require "test_helper"

class DateParserTest < ActiveSupport::TestCase
  test "parse 'tomorrow at noon'" do
    reference_time = DateTime.new(2024, 4, 15, 10, 0, 0) # Arbitrary reference time
    expected = DateTime.new(2024, 4, 16, 12, 0, 0) # Expected result
    assert_equal expected, DateParser.parse('tomorrow at noon', reference_time)
  end
  test "parse 'next Monday at early morning'" do
    reference_time = DateTime.new(2024, 4, 15)
    expected_monday = reference_time.beginning_of_week(:sunday) + 1.week
    expected = DateTime.new(expected_monday.year, expected_monday.month, expected_monday.day, 6, 0, 0)
    assert_equal expected, DateParser.parse('next Monday at early morning', reference_time)
  end

  test "parse 'next Friday at late evening'" do
    reference_time = DateTime.new(2024, 4, 15)
    next_friday = reference_time + 4.day
    expected = DateTime.new(next_friday.year, next_friday.month, next_friday.day, 21, 0, 0)
    assert_equal expected, DateParser.parse('next Friday at late evening', reference_time)
  end

  test "parse 'next Friday at 6pm'" do
    reference_time = DateTime.new(2024, 4, 15)
    next_friday = reference_time + 4.day
    expected = DateTime.new(next_friday.year, next_friday.month, next_friday.day, 21, 0, 0)
    assert_equal expected, DateParser.parse('next Friday at late evening', reference_time)
  end

  # Add more tests for edge cases and other expressions as needed
end
