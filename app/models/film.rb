class Film < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :reviews
  has_many :film_relationships
  has_many :members, through: :film_relationships, source: :user

end
