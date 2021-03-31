class Admin::OrdersController < ApplicationController
  
  
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @orders = Order.all
     # 商品合計(送料なし)
    @payment_without_shipping = @order.total_payment -= @order.shipping_cost
    # 商品合計(送料あり)
    @payment_with_shipping = @order.total_payment += @order.shipping_cost
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(admin_order_params)
      if @order.order_status == "Already shipped out"
        @order.order_details.each do |order_detail|
      		order_detail.update(making_status: "出荷完了")
        end
      end
      flash[:notice] = "編集を保存しました。"
      redirect_to admin_orders_path
    else
      render :show
    end
  end


  private

  def admin_order_params
    params.require(:order).permit(:order_status)
  end
  
end
