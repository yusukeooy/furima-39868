class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_item, only: [:show, :edit, :update, :destroy]
  
  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end
  
  def edit
    if current_user.id == @item.user_id || @item.order.present? 
       render :edit
    else
       redirect_to root_path
    end
  end
  
  def update
    if @item.update(item_params)
       redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
 
  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def load_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:item_name,:item_info,:category_id,:sales_status_id,:shipping_fee_status_id,:prefecture_id,:scheduled_delivery_id,:price,:image).merge(user_id: current_user.id)
  end
end
