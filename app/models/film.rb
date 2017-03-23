class Film < ApplicationRecord
  validates :name, presence: true
  before_action :authernticate_user! , only: [:new]
end
