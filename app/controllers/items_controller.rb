class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :back_to_top, only: [:edit, :update, :destroy]
  before_action :search_product, only: [:index, :show, :search]
  before_action :items, only: [:index, :show]

  def index

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
    @comments = @item.comments
    @comment = Comment.new

    if user_signed_in?
      gon.current_user = current_user.nickname
      if current_user.id == @item.user_id
        gon.seller = true
      else
        gon.seller = false
      end
    end
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

  def search
    @results = @p.result
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

  def search_product
    @p = Item.ransack(params[:q])
  end

  def items
    @items = Item.all.includes(:purchase)
  end
end