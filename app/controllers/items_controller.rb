class ItemsController < ApplicationController
  before_filter :find_item, only: [:show, :remember, :forget, :edit]
  load_and_authorize_resource

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(whitelisted_params)
    @item.user = current_user
    if @item.save
      flash[:now] = "Saved a new item to remember."
      redirect_to [@user, @item]
    else
      flash[:alert] = "Sorry, incorrect input.  Lets try again."
      render :new
    end
  end

  def show
  end

  def edit
    @item = Item.new(whitelisted_params)
    if @item.save
      redirect_to @item
    else
      flash[:alert] = "Sorry, incorrect input.  Lets try again."
      render :new
    end
  end

  def remember
    @item.remember
    redirect_to current_user
  end

  def forget
    @item.forget
    redirect_to current_user
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
