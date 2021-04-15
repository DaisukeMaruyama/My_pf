class Public::ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  
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
    #レビューrenderの代入、ページネーションさせるため
    @items_review = @item.reviews.order(created_at: :desc).page(params[:page]).per(5)
    #関連商品の代入(詳細ページの製品は除く為にwhere.not)
    @related_items = Item.where(genre_id: @item.genre_id).where.not(id: @item.id)
  end
  
end
