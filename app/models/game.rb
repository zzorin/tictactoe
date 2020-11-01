class Game < ApplicationRecord
  has_many :participants
  has_many :moves
  accepts_nested_attributes_for :participants

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
    return self.finish!(current_move.player) if self.moves.where(x: current_move.x, player: current_move.player).count == self.size ||
                                                self.moves.where(y: current_move.y, player: current_move.player).count == self.size
    #diag
    if current_move.x == current_move.y
      (1..self.size).each do |i|
        puts self.moves.find_by(x: i, y: i)&.id
        break if self.moves.find_by(x: i, y: i)&.player != current_move.player
        return self.finish!(current_move.player) if i == self.size
      end
    end
    #antidiag
    if current_move.x + current_move.y == self.size + 1
      (1..self.size).each do |i|
        puts self.moves.find_by(x: i, y: (self.size + 1) - i)&.id
        break if self.moves.find_by(x: i, y: (self.size + 1) - i)&.player != current_move.player
        return self.finish!(current_move.player) if i == self.size
      end
    end

    if self.moves.count == self.size**2
      return self.finish!
    end
  end

  def set_winner(winner = nil)
    self.update(winner: winner)
  end
end
