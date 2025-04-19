class DashboardController < ApplicationController
  def show
    if current_user.nil?
      redirect_to new_session_path and return
    end

    @profile = current_user.profile || current_user.create_profile
    @daily_log = current_user.daily_logs.includes(food_entries: :food).find_or_create_by(date: Date.today)

    calorie_calculator = CalorieCalculator.new
    @total_calories = calorie_calculator.calculate_total_calories
    @remaining_calories = 2000 - @total_calories

    @foods = []

    @daily_calories_weekly = calorie_calculator.calculate_daily_calories(7)
    @daily_calories_monthly = calorie_calculator.calculate_daily_calories(30)
  end
end
