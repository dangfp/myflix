class RelationshipsController < ApplicationController
  before_action :require_sign_in, only: [:create, :destroy]

  def create
    followed_user = User.find(params[:followed_user_id])
    unless current_user.following?(followed_user) || current_user == followed_user
      current_user.follow!(followed_user)
    end
    redirect_to following_user_path(current_user)
  end

  def destroy
    followed_user = User.find(params[:id])
    current_user.unfollow!(followed_user)
    redirect_to following_user_path(current_user)
  end
end