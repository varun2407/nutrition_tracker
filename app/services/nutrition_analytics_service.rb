class NutritionAnalyticsService
  def initialize(user)
    @user = user
  end

  def calculate_macro_distribution(start_date = 30.days.ago, end_date = Date.today)
    daily_logs = @user.daily_logs.includes(food_entries: :food)
                     .where(date: start_date..end_date)

    total_carbs = 0
    total_protein = 0
    total_fat = 0

    daily_logs.each do |log|
      log.food_entries.each do |entry|
        total_carbs += entry.food.carbs * entry.quantity
        total_protein += entry.food.protein * entry.quantity
        total_fat += entry.food.fat * entry.quantity
      end
    end

    total = total_carbs + total_protein + total_fat

    {
      carbs: (total_carbs.to_f / total * 100).round(1),
      protein: (total_protein.to_f / total * 100).round(1),
      fat: (total_fat.to_f / total * 100).round(1)
    }
  end

  def calculate_meal_timing_patterns(start_date = 30.days.ago, end_date = Date.today)
    daily_logs = @user.daily_logs.includes(food_entries: :food)
                     .where(date: start_date..end_date)

    meal_times = {
      breakfast: [],
      lunch: [],
      dinner: [],
      snacks: []
    }

    daily_logs.each do |log|
      log.food_entries.each do |entry|
        meal_times[entry.meal_type.to_sym] << entry.created_at.hour
      end
    end

    meal_times.transform_values do |times|
      next 0 if times.empty?
      (times.sum.to_f / times.length).round(1)
    end
  end

  def calculate_calorie_trends(start_date = 30.days.ago, end_date = Date.today)
    daily_logs = @user.daily_logs.includes(food_entries: :food)
                     .where(date: start_date..end_date)

    daily_logs.each_with_object({}) do |log, trends|
      total_calories = log.food_entries.sum { |entry| entry.food.calories * entry.quantity }
      trends[log.date.strftime("%Y-%m-%d")] = total_calories
    end
  end

  def generate_weekly_report
    end_date = Date.today
    start_date = end_date - 7.days

    {
      average_calories: calculate_average_calories(start_date, end_date),
      macro_distribution: calculate_macro_distribution(start_date, end_date),
      meal_timing: calculate_meal_timing_patterns(start_date, end_date),
      weight_change: calculate_weight_change(start_date, end_date)
    }
  end

  private

  def calculate_average_calories(start_date, end_date)
    daily_logs = @user.daily_logs.includes(food_entries: :food)
                     .where(date: start_date..end_date)

    return 0 if daily_logs.empty?

    total_calories = daily_logs.sum do |log|
      log.food_entries.sum { |entry| entry.food.calories * entry.quantity }
    end

    (total_calories.to_f / daily_logs.count).round
  end

  def calculate_weight_change(start_date, end_date)
    weight_logs = @user.weight_logs.where(logged_date: start_date..end_date)
                      .order(logged_date: :asc)

    return nil if weight_logs.count < 2

    first_weight = weight_logs.first.weight
    last_weight = weight_logs.last.weight

    {
      change: (last_weight - first_weight).round(1),
      percentage: ((last_weight - first_weight) / first_weight * 100).round(1)
    }
  end
end
