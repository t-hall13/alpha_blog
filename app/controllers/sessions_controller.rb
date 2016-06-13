class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    #render 'new'
    #debugger
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully signed in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Something went wrong, please try again"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged Out"
    redirect_to root_path 
  end
end