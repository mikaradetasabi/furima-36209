class PurchasesController < ApplicationController
  before_action :move_to_index, expect: :index

  def index
    @purchase_residence = PurchaseResidence.new
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id || @item.purchase != nil
      redirect_to root_path 
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_residence = PurchaseResidence.new(purchase_params)
    if @purchase_residence.valid?
      pay_item
      @purchase_residence.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_residence).permit(:postal_code, :municipality, :delivery_id, :address, :phone_number, :building_name, :price).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end