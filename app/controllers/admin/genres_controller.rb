class Admin::GenresController < ApplicationController
  before_action :set_genre, only: [:edit, :update, :destroy]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genres = Genre.all
    genre = Genre.new(genre_params)
    if genre.save
      flash[:notice] = '新規登録しました'
      # redirect_to admin_genres_path
    else
      @genre = Genre.new #エラー後に続けて入力するために必要
      @genres = Genre.all #エラー後に続けて入力するために必要
      flash[:alert] = '入力してください'
      render :index
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      flash[:notice] = "更新しました"
      redirect_to admin_genres_path
    else
      flash[:alert] = "入力してください"
      render :edit
    end
  end

  def destroy
    @genre.destroy
    @genres = Genre.all
    flash[:notice] = "削除しました"
    # redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def set_genre
    @genre = Genre.find(params[:id])
  end
end
