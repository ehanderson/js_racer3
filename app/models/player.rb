class Player < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :appearances
  has_many :games, through: :appearances
  

end
