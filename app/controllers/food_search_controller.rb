class FoodSearchController < ApplicationController
  def index
    # if params[:query].present?
    #   @foods = Food.where("name LIKE ?", "%#{params[:query]}%")
    # else
    #   @foods = []
    # end
    @foods = params[:query].present? ? Food.where("name LIKE ?", "%#{params[:query]}%") : []

    if @foods.empty? && params[:query].present?
      Rails.logger.debug("Query received: #{params[:query]}")
      search = SearchResults.new
      ai_result = search.display_calorie_information(params[:query])
      @foods = [ai_result] if ai_result
    end

    respond_to do |format|
      format.turbo_stream { render partial: "food_search/search", locals: { foods: @foods, daily_log_id: params[:daily_log_id], profile_id: params[:profile_id] } }
      format.html { render partial: "food_search/search", locals: { foods: @foods, daily_log_id: params[:daily_log_id], profile_id: params[:profile_id] } }
    end
  end
end
