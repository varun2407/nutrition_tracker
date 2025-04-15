class FoodEntriesController < ApplicationController
  def create
    # Get profile and daily_log from route
    profile = Profile.find(params[:profile_id])
    @daily_log = profile.daily_logs.find(params[:daily_log_id])
    @food = Food.find_or_create_by(params[:food_id])

    @food_entry = @daily_log.food_entries.create(
      food: @food,
      quantity: params[:quantity] || 1,
      meal_type: params[:meal_type] || :breakfast
    )

    if @food_entry.persisted?
      flash[:success] = "Food entry created successfully."
      redirect_to profile_daily_log_path(profile, @daily_log)
    else
      flash[:error] = "Failed to create food entry."
      render :new
    end
  end
end
