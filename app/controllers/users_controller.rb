class UsersController < ApplicationController

  before_action :require_login!, except: [:index, :new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    if current_user
      redirect_to user_url(current_user)
    else
      render :index
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:messages] = ["user updated"]
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
