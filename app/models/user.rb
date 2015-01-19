class User < ActiveRecord::Base
  has_secure_password validation: false

  validates_presence_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  validates_uniqueness_of :email

  validates_presence_of :password
  validates_length_of :password, in: 6..20

  validates_presence_of :full_name
  validates_length_of :full_name, in: 3..20
end