class Video < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    if search_term.blank?
      return []
    else
      where("title LIKE ?", "%#{search_term}%").order(:title)
    end
  end
end