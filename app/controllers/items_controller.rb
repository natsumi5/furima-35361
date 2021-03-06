class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:show, :edit, :update, :destroy]
  before_action :item_find, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_index, only: [:edit, :update, :destroy]
  before_action :move_top_page, only: [:edit, :update]
  

  def index
    @items = Item.order(id: 'DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
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
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :burden_id, :prefecture_id, :day_to_ship_id,
                                 :price).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def redirect_to_index
    redirect_to action: :index unless current_user.id == @item.user_id
  end

  def move_top_page
    redirect_to root_path if Purchase.exists?(item_id: params[:id])
  end

  def move_to_index
    redirect_to action: :index unless Item.exists?(id: params[:id])
  end
end
