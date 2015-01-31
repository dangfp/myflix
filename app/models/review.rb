class Review < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: User
  belongs_to :video

  validates_presence_of :content, :rating
  validates_numericality_of :rating, only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5
end