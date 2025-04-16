class FoodSearchController < ApplicationController
  def index
    # if params[:query].present?
    #   @foods = Food.where("name LIKE ?", "%#{params[:query]}%")
    # else
    #   @foods = []
    # end
    @foods = params[:query].present? ? Food.where("name LIKE ?", "%#{params[:query]}%") : []

    if @foods.empty? && params[:query].present?
      search = SearchResults.new
      ai_result = search.display_calorie_information(params[:query])
      @foods = [ ai_result ] if ai_result

        if ai_result
          @foods = [ Food.find_or_create_by(name: ai_result[:name]) do |food|
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
