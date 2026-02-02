class AnalyticsController < ApplicationController
  before_action :require_authentication

  def index
    @analytics_service = NutritionAnalyticsService.new(current_user)

    @macro_distribution = @analytics_service.calculate_macro_distribution
    @meal_timing = @analytics_service.calculate_meal_timing_patterns
    @calorie_trends = @analytics_service.calculate_calorie_trends
    @weekly_report = @analytics_service.generate_weekly_report
  end

  private

  def require_authentication
    unless authenticated?
      redirect_to new_session_path, alert: "Please sign in to access this page."
    end
  end
end
