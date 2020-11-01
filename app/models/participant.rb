class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :game
  scope :players, -> { where(role: ['x', 'o']) }

  # ROLES = %w(x_player o_player spectator).freeze
end
