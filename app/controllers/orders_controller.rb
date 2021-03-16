class OrdersController < ApplicationController



  def new
    @order = Order.new
    #@Delivery = Delivery.new
    @user = User.find(current_user.id)
    #@registered_addresses = Delivery.where(user_id: current_user.id)
  end

  def show
    #@order = Order.find(params[:id])
  end

  def index
    @orders = Order.all
  end

  def confirm

    @order = current_user.order.build(set_order)

    @order.total_payment = current_user.cart_items.inject(0){|sum, cart_item| cart_item.subtotal_price + sum} + @order.international_shipping_fee.to_i

    case params[:address_type]
    when "0"
      @order.postal_code = current_user.postal_code
      @order.address = current_user.address
      @order.name = current_user.last_name + current_user.first_name
    when "1"
      current_user.deliveries.each do |delivery|
        @order.postal_code = delivery.postal_code
        @order.address = delivery.address
        @order.name = delivery.name
      end
    when "2"
    end
  end

  def create
    @order = current_user.order.build(set_order)
    @shipping_cost = 800
    @order.total_payment = current_user.cart_items.inject(0){|sum, cart_item| cart_item.subtotal_price + sum} + shipping_cost

    unless @order.valid?
      @delivery = Delivery.new
      render :new
    end

     @order.save
      current_user.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item.id
        @order_detail.price = cart_item.item.price_with_tax
        @order_detail.amount = cart_item.amount
        @order_detail.making_status = 0
        @order_detail.save
      end
      #Addressに登録する処理
    #Delivery.create(customer_id: current_user.id, postal_code: @order.postal_code, address: @order.address, name: @order.name)
    #current_user.cart_items.destroy_all
   # redirect_to orders_thanks_path
   
   
   
  end

  def thanks
  end



  private

  def set_order
    params.require(:order).permit(:total_payment, :payment_method, :address, :postal_code, :last_name, :first_name, :city, :country, :shipping_method)
  end

end
