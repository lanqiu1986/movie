class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :films
  has_many :reviews
  has_many :film_relatinships
  has_many :participated_films, :through => :film_relatinships, :source => :film

  def is_favor_of?(film)
    participated_films.include?(film)
  end

  def favorite_join!(film)
    participated_films << film
  end

  def favorite_cancel!(film)
    participated_films.delete(film)
  end
end
