class Admin::GenresController < ApplicationController
  
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.create(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルの追加をしました。"
      redirect_to admin_genres_path
    else
      @genres=Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
     @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルの編集を保存しました。"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end
  
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    flash[:notice] = "ジャンルを削除しました。"
    redirect_to admin_genres_path
  end
  
  private

  def genre_params
    params.require(:genre).permit(:genre_name)
  end
  
end
