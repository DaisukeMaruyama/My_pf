class Admin::OrderDetailsController < ApplicationController
  
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(admin_order_detail_path)
    flash[:notice] = "制作ステータスの変更をしました。"

    case @order_detail.making_status
      when "制作中"
        @order_detail.order.update(order_status: "製作中")
      when "制作完了"
        if @order_detail.order.order_details.all?{ |order_detail| order_detail.making_status == "制作完了" }
          @order_detail.order.update(order_status: "発送準備中")
        end
    end
    redirect_to admin_order_path(@order_detail.order.id)
  end

  private

  def admin_order_detail_path
    params.require(:order_detail).permit(:making_status)
  end
  
end
