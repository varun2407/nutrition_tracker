class FoodEntriesController < ApplicationController
  def create
    @daily_log = current_user.daily_logs.find(params[:daily_log_id])
    @food = Food.find(params[:food_id])

    @food_entry = @daily_log.food_entries.create(
      food: @food,
      quantity: params[:quantity] || 1,
      meal_type: params[:meal_type] || :breakfast
    )

    if @food_entry.persisted?
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "dashboard_food_log",
            html: render_to_string(
              partial: "dashboard/food_log",
               locals: { food_entry: @food_entry }
            )
          )
        end
        format.html do
          flash[:success] = "Food entry created successfully."
          @daily_log.reload
        end
      end
    else
      flash[:error] = "Failed to create food entry."
      render :new
    end
  end

  def destroy
    food_entry = FoodEntry.find(params[:id])
    food_entry.destroy

    redirect_to root_path(food_entry.daily_log)
  end
end
