class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.pagination(10, params)
  end
end
