class Public::SearchController < ApplicationController

  def search
    @value = params["search"]["value"]
    @datas = search_for_item(@value).order(created_at: :desc).page(params[:page]).per(8)
  end

  def genre_search
    @content = params["search"]["content"]
    @datas = search_for_genre(@content).order(created_at: :desc).page(params[:page]).per(8)
    params[:id] = @content
    @genre = Genre.find(params[:id])
  end
  
  def genre_sort
    @genre = Genre.find(params[:id])
    @content = params[:content]
    selection = params[:keyword]
    case selection
      when 'high'
        @datas = search_for_genre(@content).order(price: :desc).page(params[:page]).per(8)
      when 'low'
        @datas = search_for_genre(@content).order(price: :asc).page(params[:page]).per(8)
      when 'new'
        @datas = search_for_genre(@content).order(created_at: :desc).page(params[:page]).per(8)
      when 'old'
        @datas = search_for_genre(@content).order(created_at: :asc).page(params[:page]).per(8)
    end
  end
  #↑↓両方ともmodelにロジックを書きたかったがエラーになる為、コントローラーへ記述
  def search_sort
    @value = params[:value]
    selection = params[:keyword]
    case selection
      when 'high'
        @datas = search_for_item(@value).order(price: :desc).page(params[:page]).per(8)
      when 'low'
        @datas = search_for_item(@value).order(price: :asc).page(params[:page]).per(8)
      when 'new'
        @datas = search_for_item(@value).order(created_at: :desc).page(params[:page]).per(8)
      when 'old'
        @datas = search_for_item(@value).order(created_at: :asc).page(params[:page]).per(8)
    end
  end

  private

  def search_for_genre(content)
    Item.where(genre_id: content)
  end

  def search_for_item(value)
    Item.where("item_name LIKE ?", "%#{value}%")
  end

 

  #↓前方、後方、部分、全体一致のコード。今回のアプリでは不要な機能で取り除いたが後学のためコメントアウトで残す。
  #def search
  #  @value = params["search"]["value"]
  #  @how = params["search"]["how"]
  #  @datas = search_for(@how, @value).page(params[:page]).per(8)
  #end

  #def match(value)
  #  Item.where(item_name: value)
  #end

  #def forward(value)
  #  Item.where("item_name LIKE ?", "#{value}%")
  #end

  #def backward(value)
  #  Item.where("item_name LIKE ?", "%#{value}")
  #end

  #def partical(value)
  #  Item.where("item_name LIKE ?", "%#{value}%")
  #end


  #def search_for(how, value)
  #  case how
  #  when 'match'
  #    match(value)
  #  when 'forward'
  #    forward(value)
  #  when 'backward'
  #    backward(value)
  #  when 'partical'
  #    partical(value)
  #  end
  #end

  # 仮にransackを使用する場合コントローラーへそれぞれ右を追加（今回不使用）　⇨@q = Item.ransack(params[:q])


end
