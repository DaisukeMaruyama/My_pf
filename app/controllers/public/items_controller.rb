class Public::ItemsController < ApplicationController
  
  def index
    #@items = Item.all.order(created_at: :desc)
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).order(created_at: :desc)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    if @item.reviews.blank?
      @average_review = 0
    else
      @average_review = @item.reviews.average(:rate).round(2)
    end
  end
  
end
