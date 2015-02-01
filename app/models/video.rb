class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order "created_at DESC" }
  has_many :queue_items

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    if search_term.blank?
      return []
    else
      where("title LIKE ?", "%#{search_term}%").order(:title)
    end
  end

  def rating
    reviews.count > 0 ? (reviews.collect(&:rating).sum.to_f / reviews.count).round(1) : 0
  end
end