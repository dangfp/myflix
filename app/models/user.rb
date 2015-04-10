class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order "position ASC" }

  has_many :relationships, foreign_key: 'follower_id'
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: 'Relationship'
  has_many :followers, through: :reverse_relationships

  has_secure_password validation: false

  validates_presence_of :email
  validates_format_of :email, with: /@/, on: :create
  validates_uniqueness_of :email

  validates_presence_of :password
  validates_length_of :password, in: 6..20

  validates_presence_of :full_name
  validates_length_of :full_name, in: 3..20

  def reorder_queue_items_position
    queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
end