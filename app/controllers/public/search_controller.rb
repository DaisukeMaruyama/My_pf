class Public::SearchController < ApplicationController

  def search
    @value = params["search"]["value"]
    @datas = search_for_item(@value).page(params[:page]).per(8)
  end
  
  def genre_search
    @content = params["search"]["content"]
    @datas = search_for_genre(@content).page(params[:page]).per(8)
    params[:id] = @content
    @genre = Genre.find(params[:id])
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
