class Admin::OrderDetailsController < ApplicationController
  
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(admin_order_detail_path)
    flash[:notice] = "制作ステータスの変更をしました。"
    redirect_to admin_order_path(@order_detail.order.id)
  end

  private

  def admin_order_detail_path
    params.require(:order_detail).permit(:making_status)
  end
  
end
