class FoodEntriesController < ApplicationController
  def create
    # Get profile and daily_log from route
    profile = Profile.find(params[:profile_id])
    @daily_log = profile.daily_logs.find(params[:daily_log_id])
    @food = Food.find(params[:food_id])

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

  def destroy
    food_entry = FoodEntry.find(params[:id])
    food_entry.destroy

    redirect_to profile_daily_log_path(food_entry.daily_log.profile, food_entry.daily_log), notice: "Food entry deleted successfully."
  end
end
