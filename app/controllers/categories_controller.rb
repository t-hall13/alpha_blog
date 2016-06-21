class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 4)
  end
  
  def new
    @category = Category.new
  end
  
  def show
   # @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 4)
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
  
  def edit
    #@category = Category.find(params[:id])
  end
  
  def update
    if @category.update(category_params)
      flash[:success] = "Category name successfully updated"
      redirect_to category_path(@category)
    else
      flash[:danger] = "Something went wrong, please try again"
      render 'edit'
    end
  end
  
  def destroy
     @category.destroy
     flash[:success] = "'#{@category.name}' successfully deleted"
     redirect_to categories_path
  end
  
  private
  def category_params
    params.require(:category).permit :name
  end
  
  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "Only Admin Users can perform that action!"
      redirect_to categories_path
    end
  end
  
  def set_category
    @category = Category.find(params[:id])
  end
end