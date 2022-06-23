class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all

    @reviews = @item.reviews_with_id
    @review = @reviews.new
  end

  def genre_search
    @genres = Genre.all
    items = Item.genre_search(params[:genre_id])
    @items = items.page(params[:page]).per(8)
    @genre_name = Genre.find(params[:genre_id]).name
  end

  def word_search
    @genres = Genre.all
    @items_search = Item.search(params[:keyword]).page(params[:page]).per(8)
  end
end
