class UsersController < ApplicationController
  before_action :authenticate_user, except: %i[new create]
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_admin, only: %i[index]
  before_action :require_correct_user, only: %i[show edit update destroy]
  before_action :restrict_admin, only: %i[edit update]

  def index
    @users = User.where(role: "user")
  end

  def show
    @products = @user.bids
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      flash[:notice] = "Welcome, #{@user.first_name}!"
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Account updated!"
      redirect_to edit_user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.admin?
      @user.destroy
      flash[:notice] = "User deleted!"
      redirect_to users_path
    else
      log_out
      @user.destroy
      flash[:notice] = "Account deleted!"
      redirect_to root_url
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
