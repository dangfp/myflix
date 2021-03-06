class QueueItemsController < ApplicationController
  before_action :require_sign_in

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    queue_video(video)
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.delete if queue_item.user == current_user
    current_user.reorder_queue_items_position
    
    redirect_to my_queue_path
  end

  def update
    begin
      update_queue_items
      current_user.reorder_queue_items_position
    rescue
      flash[:danger] = "Invalid position numbers."
    end
    
    redirect_to my_queue_path
  end

  private

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id])
        queue_item.update!(position: queue_item_data[:position], rating: queue_item_data[:rating]) if queue_item.user == current_user
      end
    end
  end

  def queue_video(video)
    QueueItem.create(video: video, user: current_user, position: new_position) unless current_user_queued_video?(video)
  end

  def new_position
    current_user.queue_items.count + 1
  end

  def current_user_queued_video?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
end