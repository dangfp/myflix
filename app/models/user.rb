class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order "position ASC" }

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
end