class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :back_to_top, only: [:edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC').includes(:purchase)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to action: :index
  end


  private

  def item_params
    params.require(:item).permit({images: []}, :name, :description, :category_id, :condition_id, :delivery_charge_id, :prefecture_id,
                                 :delivery_day_id, :price).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.includes(:purchase).find(params[:id])
  end

  def back_to_top
    if @item.purchase != nil || current_user.id != @item.user_id
      redirect_to root_path
    end
  end
end
