class Film < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :reviews
end
