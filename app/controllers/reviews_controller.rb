class ReviewsController < ApplicationController
  before_action :require_sign_in

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.build(review_params)
    review.creator = current_user

    if review.save
      flash[:success] = "You've reviewed success."
      redirect_to video_path(@video)
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :creator, :video)
  end
end