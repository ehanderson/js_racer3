class Game < ActiveRecord::Base
  has_many :appearances
  has_many :players, through: :appearances
end
