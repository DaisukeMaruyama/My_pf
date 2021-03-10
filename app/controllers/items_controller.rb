class ItemsController < ApplicationController
  
  def index
    @items = Item.all.order(created_at: :desc)
    @genres = Genre.all
  end

  def show
    @item = Ite.find(params[:id])
  end
  
end
