class Public::SearchController < ApplicationController

  def search
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @value)
  end
  
  def genre_search
    @content = params["search"]["content"]
    @datas = search_for_genre(@content)
    params[:id] = @content
    @genre = Genre.find(params[:id])
  end
  
  private
  
  def search_for_genre(content)
    Item.where(genre_id: content)
  end
  
  def match(value)

    Item.where(item_name: value)
  end

  def forward(value)
    Item.where("item_name LIKE ?", "#{value}%")
  end

  def backward(value)
    Item.where("item_name LIKE ?", "%#{value}")
  end

  def partical(value)
    Item.where("item_name LIKE ?", "%#{value}%")
  end


  def search_for(how, value)
    case how
    when 'match'
      match(value)
    when 'forward'
      forward(value)
    when 'backward'
      backward(value)
    when 'partical'
      partical(value)
    end
  end
  



end
