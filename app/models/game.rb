class Game < ApplicationRecord
  has_many :participants, dependent: :destroy
  has_many :moves, dependent: :destroy
  accepts_nested_attributes_for :participants
  validates :size, presence: true

  include AASM

  aasm do
    state :created, initial: true
    state :started
    state :finished

    event :start do
      transitions from: :created, to: :started
    end

    event :finish, after: :set_winner do
      transitions from: :started, to: :finished
    end
  end

  def check_game_progress(current_move)
    game_size = self.size > 5 ? 5 : self.size
    #x
    coordinates_x = self.moves.where(x: current_move.x, player: current_move.player).pluck(:y).sort
    return self.finish!(current_move.player) if game_finished?(game_size, coordinates_x)
    #y
    coordinates_y = self.moves.where(y: current_move.y, player: current_move.player).pluck(:x).sort
    return self.finish!(current_move.player) if game_finished?(game_size, coordinates_y)

    #diag
    if current_move.x == current_move.y
      coordinates_diag = []
      (1..self.size).each do |i|
        coordinates_diag << self.moves.find_by(x: i, y: i, player: current_move.player)&.x
      end
      puts coordinates_diag
      return self.finish!(current_move.player) if game_finished?(game_size, coordinates_diag.compact.sort)
    end
    #antidiag
    if current_move.x + current_move.y == self.size + 1
      coordinates_antidiag = []
      (1..self.size).each do |i|
        coordinates_antidiag << self.moves.find_by(x: i, y: (self.size + 1) - i, player: current_move.player)&.x
      end
      return self.finish!(current_move.player) if game_finished?(game_size, coordinates_antidiag.compact.sort)
    end

    if self.moves.count == self.size**2
      return self.finish!
    end
  end

  def set_winner(winner = nil)
    self.update(winner: winner)
  end

  def game_finished?(game_size, coordinates)
    if coordinates.size >= game_size
      current_size = 0
      coordinates[1..-1].each_with_index do |coordinate, i|
        if (coordinate - coordinates[i]) == 1
          current_size = current_size + 1
          return true if current_size + 1 == game_size
        else
          current_size = 0
        end
      end
    end
    false
  end
end
