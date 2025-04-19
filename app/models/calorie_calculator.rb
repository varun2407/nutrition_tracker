class CalorieCalculator
  def calculate_total_calories
    current_date = Date.today

    daily_log = DailyLog.find_by(date: current_date)

    return 0 unless daily_log

    total_calories = daily_log.food_entries.includes(:food).sum do |entry|
      entry.quantity * entry.food.calories
    end

    total_calories
  end

  def calculate_daily_calories(days)
    start_date = Date.today - days
    date_range = (start_date..Date.today).to_a

    daily_calories = date_range.each_with_object({}) do |date, hash|
      hash[date.strftime("%b %d")] = 0
    end

    logs = DailyLog.where(date: date_range)
    logs.each do |log|
      day_key = log.date.strftime("%b %d")
      daily_calories[day_key] = log.food_entries.sum { |entry| entry.quantity * entry.food.calories }
    end

    daily_calories
    # => {"Apr 11" => 0, "Apr 12" => 0, "Apr 13" => 0, "Apr 14" => 0, "Apr 15" => 0, "Apr 16" => 0, "Apr 17" => 0, "Apr 18" => 408}
  end
end
