class ItemsController < ApplicationController
  before_filter :find_item, only: [:show, :remember, :forget, :edit, :destroy]

  def index
    @items = current_user.items.order(:reminder_date)
    render json:  @items
  end

  def create
    @item = Item.new(whitelisted_params)
    @item.user = current_user
    if @item.save
      render json: @item, status: 200
    else
      render json: {}, status: 422
    end
  end

  def show
  end

  def remember
    @item.remember
    render json: @item, status: 200
  end

  def forget
    @item.forget
    render json: @item, status: 200
  end

  def destroy
    @item.destroy
    render json: {}, status: :ok
  end

  def default_serializer_options
    {
      root: false
    }
  end

  private
  def find_item
    if params[:id].present?
      @item = Item.find params[:id]
    end
  end

  def whitelisted_params
    params.require(:item).permit(:question, :answer)
  end
end
