class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase_shipping = PurchaseShipping.new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_shipping_params)
    if @purchase_shipping.valid?
      @purchase_shipping.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def purchase_shipping_params
    params.require(:purchase_shipping).permit(:postal_code, :prefecture_id, :address, :address_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end