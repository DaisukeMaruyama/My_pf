class Public::DeliveriesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @deliveries = Delivery.all
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.create(delivery_params)
    @delivery.user_id = current_user.id
    if @delivery.save
      flash[:notice] = "You have registered delivery address"
      redirect_to deliveries_path
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      flash[:notice] = "You have updated delivery address"
      redirect_to deliveries_path
    end 
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
      flash[:notice] = "You have deleted delivery address"
      redirect_to deliveries_path
  end
  
  private
  
  def correct_user
    @delivery = Delivery.find(params[:id])
    if @delivery.user_id != current_user.id
       flash[:alert] = "You are not autholized."
       redirect_to deliveries_path
    end
  end
  
  def delivery_params
    params.require(:delivery).permit(
      :first_name, 
      :last_name, 
      :delivery_address, 
      :delivery_city, 
      :delivery_country, 
      :delivery_postal_code
      )
  end
  
end
