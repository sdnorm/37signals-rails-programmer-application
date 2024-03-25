class DateParser < ApplicationRecord
  WEEKDAYS = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday].freeze

  def self.parse(expression, reference_time = DateTime.now)
    date_part, time_part = expression.split(' at ')
    date = parse_date(date_part.strip, reference_time.to_date)
    time = parse_time(time_part ? time_part.strip : 'now', reference_time)

    DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec, time.zone)
  end

  private

  def self.parse_date(date_expression, reference_date)
    case date_expression.downcase
    when 'tomorrow'
      reference_date + 1
    when /next (\w+)/
      weekday_to_date($1, reference_date, 1)
    when /last (\w+)/
      weekday_to_date($1, reference_date, -1)
    when 'end of the month'
      Date.new(reference_date.year, reference_date.month, -1)
    # Add other specific and relative date cases here
    else
      Date.parse(date_expression) rescue reference_date
    end
  end

  def self.weekday_to_date(weekday, reference_date, direction)
    day_index = WEEKDAYS.index(weekday.capitalize)
    days_until = (day_index - reference_date.wday) % 7
    days_until += 7 if direction.positive? && days_until.zero?
    days_until -= 7 if direction.negative? && days_until.zero?
    reference_date + direction * days_until
  end

  def self.parse_time(time_expression, reference_time)
    case time_expression.downcase
    when 'now'
      reference_time
    when 'noon'
      reference_time.change(hour: 12, min: 0)
    when 'midnight'
      reference_time.change(hour: 0, min: 0)
    when /early morning/
      reference_time.change(hour: 6, min: 0)
    when /late evening/
      reference_time.change(hour: 21, min: 0)
    when /(\d+) minutes from now/
      reference_time + ($1.to_i * 60)
    when /(\d+) hours before now/
      reference_time - ($1.to_i * 60 * 60)
    # Add other specific time expressions and relative times as needed
    else
      parse_explicit_time(time_expression, reference_time)
    end
  end
  
  def self.parse_explicit_time(time_expression, reference_time)
    parsed_time = DateTime.parse(time_expression) rescue nil
    if parsed_time
      reference_time.change(hour: parsed_time.hour, min: parsed_time.min, sec: parsed_time.sec)
    else
      reference_time
    end
  end
end
