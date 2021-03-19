class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.update(user_params)
    if @user.save
      flash[:notice] = "You have updated your information"
    redirect_to 
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def unsubscribe
  end

  def withdraw
  end
  
end
