class Public::PaypalController < ApplicationController
  include Paypal::SDK:REST
   
  def create
    
    pay = ( params[:amount].to_d * 100).to_i
    
    payment = Payment.new({
      intent: 'sale',
      payer: {
        payment_method: 'paypal'
      },
      redirect_urls: {
        return_url: orders_thanks_path,
        cancel_url: orders_confirm_path
      },
      transactions: [
        {
          amount: {
            total: pay,
            currency: 'usd'
          },
          description: 'Payment',
        }
      ]
    })


    @order = current_user.orders.new
      @order.total_payment = params[:amount].to_d
      @order.address = params[:address]
      @order.postal_code = params[:postal_code]
      @order.last_name = params[:last_name]
      @order.first_name = params[:first_name]
      @order.city = params[:city]
      @order.country = params[:country]
      @order.shipping_cost = @order.international_shipping_fee.to_d
      @order.save

    current_user.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item.id
        @order_detail.price = cart_item.item.price
        @order_detail.amount = cart_item.amount
        @order_detail.making_status = "出荷作業中"
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


  end


  
end