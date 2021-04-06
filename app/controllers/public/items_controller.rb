class Public::ItemsController < ApplicationController
  
  def index
    #@items = Item.all.order(created_at: :desc)
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(8)
    @genres = Genre.all
  end
  
  def condition_search
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    if @item.reviews.blank?
      @average_review = 0
    else
      @average_review = @item.reviews.average(:rate).round(2)
    end
    @items_review = @item.reviews.order(created_at: :desc).page(params[:page]).per(5)
  end
  
end
