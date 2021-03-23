class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      sign_in(@user, :bypass => true)#パスワードを変えたときにログインキープ
      flash[:notice] = "You have updated your information"
      redirect_to user_path
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def unsubscribe
    @user = User.find(current_user.id)
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: "Deleted")
    reset_session
    flash[:notice] = "Thank you very much for using SnackBen! We hope to serving you again."
    redirect_to root_path
  end
  
  def newpassword
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :city, :country, :postal_code, :password, :password_confirmation)
  end
  
end