class Public::OrdersController < ApplicationController



  def new
    @order = Order.new
    @user = User.find(current_user.id)
    @registered_addresses = Delivery.where(user_id: current_user.id)
    @Delivery = Delivery.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all
  end

  def confirm

    @order = current_user.orders.build(set_order)

    @order.total_payment = current_user.cart_items.inject(0){|sum, cart_item| cart_item.subtotal_price + sum} + @order.international_shipping_fee.to_i

    case params[:address_type]
    when "0"
      @order.postal_code = current_user.postal_code
      @order.address = current_user.address
      @order.last_name = current_user.last_name 
      @order.first_name = current_user.first_name
      @order.city = current_user.city
      @order.country = current_user.country
    when "1"
      delivery = Delivery.find(params[:order][:delivery_id])
        @order.postal_code = delivery.delivery_postal_code
        @order.address = delivery.delivery_address
        @order.last_name = delivery.last_name
        @order.first_name = delivery.first_name
        @order.city = delivery.delivery_city
        @order.country = delivery.delivery_country
    when "2"
    end

  end

  def pay
    
    
    total = ( params[:amount].to_d * 100).to_i
    #hidden_field_tagで受け取った値を計算。stripeは小数点の値を受け取れない。ドル換算の場合は１００をかける。.to_iは整数を数字に変える。
      customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )


      charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => total,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    
    unless @order.valid?
      @delivery = Delivery.new
      render :new
    end
  
    @order = current_user.orders.new
      @order.total_payment = params[:amount].to_d
      @order.address = params[:address]
      @order.postal_code = params[:postal_code]
      @order.last_name = params[:last_name]
      @order.first_name = params[:first_name]
      @order.city = params[:city]
      @order.country = params[:country]
      @order.save

    current_user.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item.id
        @order_detail.price = cart_item.item.price
        @order_detail.amount = cart_item.amount
        @order_detail.making_status = 0
        @order_detail.save
    end
    
    #Addressに登録する処理
    Delivery.create(
      user_id: current_user.id, 
      delivery_postal_code: @order.postal_code,
      delivery_address: @order.address,
      delivery_city: @order.city,
      delivery_country: @order.country,
      last_name: @order.last_name,
      first_name: @order.first_name
      )

    current_user.cart_items.destroy_all
    redirect_to orders_thanks_path
  

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to orders_confirm_path


  end


  def thanks
  end


  private

  def set_order
    params.require(:order).permit(:payment_method, :address, :postal_code, :last_name, :first_name, :city, :country)
  end

end
