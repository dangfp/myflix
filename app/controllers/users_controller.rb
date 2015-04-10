class UsersController < ApplicationController
  before_action :require_sign_in, only: [:show, :following]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "You are registered successfully."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def following
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end