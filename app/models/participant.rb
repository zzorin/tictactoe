class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :game
  scope :players, -> { where(role: ['x', 'o']) }
  validates :role, inclusion: { in: [ 'x', 'o', 'spectator' ] }
  validates_uniqueness_of :role,
                          scope: [:game_id],
                          conditions: -> { where(role: ['x', 'o']) },
                          message: 'У каждого типа игрока может быть только один пользователь'

end
