class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    item.save
    redirect_to admin_items_path
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    @item.update(item_params)
    redirect_to admin_item_path(params[:id])
  end
  
  def word_search
  @search_items = Item.others(current_item).search(params[:keyword])
end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
