class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  before_action :set_item, only: %i[index create]

  def index
    if (current_user.id == @item.user.id) || @item.order.present?
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      @order_shipping_address = OrderShippingAddress.new
    end
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(address_params)
    if @order_shipping_address.valid?
      pay_item
      @order_shipping_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def address_params
    params.require(:order_shipping_address).permit(:portal_code, :prefecture_id, :city, :address, :building, :phone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: address_params[:token],
      currency: 'jpy'
    )
  end
end