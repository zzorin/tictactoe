class Move < ApplicationRecord
  belongs_to :game
  validates :x, :y, :player, presence: true
end
