class UsersController < ApplicationController
  before_filter :find_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new permitted_params
    if @user.save
      flash[:notice] = "User created"
      redirect_to action: :index
    else
      flash[:alert] = "Error in user creation"
      redirect_to :back
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes permitted_params
      flash[:notice] = "User created"
      redirect_to action: :index
    else
      flash[:alert] = "Error in user creation"
      redirect_to :back
    end
  end

  private
  def find_user
    if params[:id].present?
      @user = User.find params[:id]
    end
  end

  def permitted_params
    params.require(:user).permit(:firstname, :lastname, :email)
  end
end
