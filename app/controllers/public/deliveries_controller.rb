class Public::DeliveriesController < ApplicationController
  
  def index
    @deliveries = Delivery.all
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.create(delivery_params)
    if @delivery.save
      flash[:notice] = "You have registered delivery address"
      redirect_to deliveies_path
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      flash[:notice] = "You have updated delivery address"
      redirect_to deliveies_path
    end 
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to deliveies_path
  end
  
  private
  
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
