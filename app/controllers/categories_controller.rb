class CategoriesController < ApplicationController
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category successfully created"
      redirect_to categories_path
    else
      flash[:danger] = "Something went wrong, please try again"
      render 'new'
    end
  end
  def show
    
  end
  
  private
  def category_params
    params.require(:category).permit :name
  end
end