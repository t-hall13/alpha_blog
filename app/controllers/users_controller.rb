class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy ]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 4) 
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "#{ @user.username } has been successfully signed up."
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "#{ @user.username }'s profile was successfully updated"
      redirect_to articles_path
    else
      flash[:danger] = "Something went wrong, please try again"
      render 'edit'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end