class ItemsController < ApplicationController
  
  def index
    @items = Item.all.order(created_at: :desc)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
  end
  
end
