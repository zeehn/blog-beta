class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully."
      redirect_to user
    else
      flash.now[:danger] = "Incorrect credentials."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "You have logged out!"
    redirect_to root_path
  end


end