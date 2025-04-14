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
end
