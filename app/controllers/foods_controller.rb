class FoodsController < ApplicationController
  before_action :set_food, only: [:edit, :update, :destroy]

  def index
    @foods = current_user.foods.order(created_at: :desc)
  end

  def new
    @food = current_user.foods.build
  end

  def create
    @food = current_user.foods.build(food_params)

    if @food.save
      redirect_to request.referer.presence || foods_path, notice: "Food created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @food.update(food_params)
      redirect_to foods_path, notice: "Food updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @food.destroy
    redirect_to foods_path, notice: "Food deleted successfully."
  end

  private

  def set_food
    @food = current_user.foods.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :calories, :carbs, :protein, :fat, :measurement_type, :unit)
  end
end

