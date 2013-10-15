class Player < ActiveRecord::Base
  has_many :appearances
  has_many :games, through: :appearances


end
