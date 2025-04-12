class FoodSearchController < ApplicationController
  def index
    # if params[:query].present?
    #   @foods = Food.where("name LIKE ?", "%#{params[:query]}%")
    # else
    #   @foods = []
    # end
    @foods = params[:query].present? ? Food.where("name LIKE ?", "%#{params[:query]}%") : []

    respond_to do |format|
      format.turbo_stream { render partial: "food_search/search", locals: { foods: @foods } }
      format.html { render partial: "food_search/search", locals: { foods: @foods } }
    end
  end
end
