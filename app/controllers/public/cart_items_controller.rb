class Public::CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:update, :destroy]

  def index
    @cart_items = CartItem.all
    @user = User.find(current_user.id)
  end

  def create
    @cart_item = current_user.cart_items.new(cart_item_params)
    if @cart_item = current_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save
      flash[:notice] = "You have added the item to your shopping cart"
      redirect_to cart_items_path
    else 
      @cart_item = current_user.cart_items.new(cart_item_params)
      @cart_item.save!
      flash[:notice] = "You have added the item to your shopping cart"
      redirect_to cart_items_path
    end
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
    flash[:notice] = "You have changed the amount of item"
    redirect_to cart_items_path
  end

  def shipping_confirm
    @cart_items = CartItem.all
    @user = User.find(current_user.id)
    @cart_item = current_user.cart_items.new(country: params[:country])
    if params[:country].empty?
      logger.warn("shipping_confirm : error")
    end
  end

  private

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
