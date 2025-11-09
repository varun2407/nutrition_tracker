class FoodSearchController < ApplicationController
  def index
    # if params[:query].present?
    #   @foods = Food.where("name LIKE ?", "%#{params[:query]}%")
    # else
    #   @foods = []
    # end
    if params[:query].present?
      # Search both system foods (user_id is nil) and user's custom foods
      @foods = Food.searchable_by(current_user).where("name LIKE ?", "%#{params[:query]}%")
    else
      @foods = []
    end

    if @foods.empty? && params[:query].present?
      search = SearchResults.new
      ai_result = search.display_calorie_information(params[:query])
      @foods = [ ai_result ] if ai_result

        if ai_result
          # Create system food (user_id = nil) if it doesn't exist
          @foods = [ Food.find_or_create_by(name: ai_result[:name], user_id: nil) do |food|
            food.calories = ai_result[:calories]
            food.carbs = ai_result[:carbs]
            food.protein = ai_result[:protein]
            food.fat = ai_result[:fat]
          end ]
        end
    end

    respond_to do |format|
      format.turbo_stream { render partial: "food_search/search", locals: { foods: @foods, daily_log_id: params[:daily_log_id], user_id: current_user.id } }
      format.html { render partial: "food_search/search", locals: { foods: @foods, daily_log_id: params[:daily_log_id], user_id: current_user.id } }
    end
  end
end
