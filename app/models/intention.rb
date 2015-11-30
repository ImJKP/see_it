class Intention < ActiveRecord::Base
  has_many :users
  has_many :movies
end
