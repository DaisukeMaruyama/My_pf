class Admin::ItemsController < ApplicationController
  
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "You have created the item"
    redirect_to items_path
    else
      render :new
    end
  end

  def new
    @item = Item.new
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      flash[:notice] = "You have updated the item"
      redirect_to items_path
    else
      render :new
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "You have deleted the item"
    redirect_to items_path
  end
  
  private
  
  def item_params
    params.require(:item).permit(:genre_id, :item_name, :image, :introduction, :price, :is_active)
  end
  
end
