class DashboardController < ApplicationController
  def show
    if current_user.nil?
      redirect_to new_session_path and return
    end

    @profile = current_user.profile
    if @profile.nil?
      @profile = current_user.create_profile
    end
    @daily_log = @profile.daily_logs.find_or_create_by(date: Date.today)

    calorie_calculator = CalorieCalculator.new
    @total_calories = calorie_calculator.calculate_total_calories
    @remaining_calories = 2000 - @total_calories

    @foods = []
  end
end
