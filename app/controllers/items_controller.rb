class ItemsController < ApplicationController
  before_filter :find_item, only: [:show, :remembered, :forgot]

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

  def remembered
    @item.remembered
    @item.save
    redirect_to :back
  end

  def forgot
    @item.forgot
    @item.save
    redirect_to :back
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
