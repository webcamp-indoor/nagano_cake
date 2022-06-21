class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.new(review_params)
    @review.customer_id = current_customer.id
    @review.save
    redirect_to item_path(@item)
  end
  
  
  def destroy
    @item = Item.find(params[:item_id])
    review = @item.reviews.find(params[:id])
    review.destroy
    redirect_to item_path(item)
  end
  
  
  private
    def review_params
      params.require(:review).permit(:content)
    end
end
