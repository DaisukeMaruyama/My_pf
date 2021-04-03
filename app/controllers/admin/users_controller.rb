class Admin::UsersController < ApplicationController
  
  def index
    #@users = User.all
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc)
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(admin_user_params)
      flash[:notice] = "会員情報の編集を保存しました。"
      redirect_to admin_user_path(@user)
    else
      render :edit
    end  
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  private
  
  def admin_user_params
    params.require(:user).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :city,
      :country,
      :postal_code,
      :address,
      :email,
      :is_deleted,
      :password
      )
  end
  
end
