class RelationshipsController < ApplicationController
  before_action :require_sign_in, only: [:create, :destroy]

  def create
    followed_user = User.find(params[:followed_user_id])
    current_user.follow!(followed_user) if current_user.can_follow?(followed_user)
    redirect_to following_user_path(current_user)
  end

  def destroy
    followed_user = User.find(params[:id])
    current_user.unfollow!(followed_user)
    redirect_to following_user_path(current_user)
  end
end