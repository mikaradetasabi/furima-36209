class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :set_root_path

  def index
    @purchase_residence = PurchaseResidence.new
  end

  def create
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
    params.require(:purchase_residence).permit(:postal_code, :municipality, :delivery_id, :address, :phone_number, :building_name).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_root_path
    if current_user.id == @item.user_id || @item.purchase != nil
      redirect_to root_path 
    end
  end
end