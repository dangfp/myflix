class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    binding.pry
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "You've successfully created category #{@category.name}."
      redirect_to categories_path
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end