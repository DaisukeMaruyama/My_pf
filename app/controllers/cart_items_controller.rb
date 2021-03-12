class CartItemsController < ApplicationController
  
  before_action :correct_user, only: [:update, :destroy]
  
  def index
    @cart_items = CartItem.all
    @user = User.find(current_user.id)
  end

  def create 
    @cart_item = current_user.cart_items.new(cart_item_params)
    @cart_item.save!
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "You have removed the item"
    redirect_to cart_items_path
  end

  def destroy_all
    @user = User.find(current_user.id)
    @user.cart_items.destroy_all
    flash[:notice] = "You have emptied all items"
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def correct_user
		@cart_item = CartItem.find(params[:id])
		if current_user.id != @cart_item.user_id
		  flash[:alert] = "You are not autholized."
			redirect_to cart_items_path
		end
  end
  
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
  
  
end
