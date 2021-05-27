class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @purchase_delivery = PurchaseDelivery.new
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_delivery = PurchaseDelivery.new(purchase_params)
    if @purchase_delivery.valid?
      @purchase_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_delivery).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

end
