class User < ActiveRecord::Base
  has_many :events

  validates :email, presence: true, length: {maximum: 255}
  validates :name, presence: true, length: {maximum: 35}
  validates :email, uniqueness: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

end
