class OrdersController < ApplicationController
  before_action :item_find
  before_action :authenticate_user!
  before_action :move_to_index

  def index
    @purchase_shipping = PurchaseShipping.new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_shipping_params)
    if @purchase_shipping.valid?
      pay_item
      @purchase_shipping.save
      redirect_to root_path
    else
      item_find
      render :index
    end
  end

  private

  def purchase_shipping_params
    params.require(:purchase_shipping).permit(:postal_code, :prefecture_id, :address, :address_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_shipping_params[:token],
      currency: 'jpy'
    )
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if (@item.user == current_user) || (Purchase.exists?(item_id: params[:item_id]))
      redirect_to root_path
    end
  end

end
