class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    if item.save
      flash[:notice] = '新規登録しました'
      redirect_to admin_items_path
    else
      @item = Item.new #エラー後に続けて入力するために必要
      flash[:alert] = '入力が間違っています'
      render :new
    end
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = '更新しました。'
      redirect_to admin_item_path(params[:id])
    else
      flash[:alert] = '入力が間違っています。'
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
