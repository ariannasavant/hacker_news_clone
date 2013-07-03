class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password_hash
  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :email, format: { with: /.+@.+\..{2,}/, message: "Valid emails only" }
end
