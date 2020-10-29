class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :game

  # ROLES = %i(x_player o_player spectator).freeze
end
