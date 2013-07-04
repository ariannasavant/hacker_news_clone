class User < ActiveRecord::Base
  include BCrypt

  validates_presence_of :username, :email, :password_hash
  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :email, format: { with: /.+@.+\..{2,}/, message: "Valid emails only" }

  has_many :posts
  has_many :comments

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(username, password)
    @user = User.find_by_username(username)
    return @user if @user.password == password
  end

end
