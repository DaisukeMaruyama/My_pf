class Public::SearchController < ApplicationController
    
  def search
    @value = params["search"]["value"]         
    @how = params["search"]["how"]             
    @datas = search_for(@how, @value)          
  end

  private

  def match(value)
    
    Item.where(item_name: value).or(Item.where(genre_id: value))
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
