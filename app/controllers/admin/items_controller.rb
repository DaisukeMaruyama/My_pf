class Admin::ItemsController < ApplicationController

  def index
    #@items = Item.all.order(created_at: :desc)
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "製品の登録をしました。"
    redirect_to admin_items_path
    else
      render :new
    end
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      flash[:notice] = "製品の編集を保存しました。"
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "製品を削除しました。"
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :item_name, :image, :introduction, :price, :is_active)
  end

end
