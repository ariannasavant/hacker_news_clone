class Post < ActiveRecord::Base
  validates_presence_of :title, :url
  validates :url, format: { with: /^(http(?:s)?\:\/\/[a-zA-Z0-9\-]+(?:\.[a-zA-Z0-9\-]+)*\.[a-zA-Z]{2,6}(?:\/?|(?:\/[\w\-]+)*)(?:\/?|\/\w+\.[a-zA-Z]{2,4}(?:\?[\w]+\=[\w\-]+)?)?(?:\&[\w]+\=[\w\-]+)*)$/, message: "Only valid URLs"}

  belongs_to :user
  has_many :comments
end
