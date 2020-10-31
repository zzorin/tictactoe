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

    event :finish do
      transitions from: :started, to: :finished
    end
  end

  def check_game_progress(current_move)
    if self.moves.count == self.size**2
      self.finish!
    end
    puts 'y'
    (1..self.size).each do |i|
      puts self.moves.find_by(x: current_move.x, y: i)&.id
      break if self.moves.find_by(x: current_move.x, y: i)&.player != current_move.player
      self.finish!(current_move.player) if i == self.size
    end
    puts 'x'
    (1..self.size).each do |i|
      puts self.moves.find_by(x: i, y: current_move.y)&.id
      break if self.moves.find_by(x: i, y: current_move.y)&.player != current_move.player
      self.finish!(current_move.player) if i == self.size
    end
    puts 'diag'
    if current_move.x == current_move.y
      (1..self.size).each do |i|
        puts self.moves.find_by(x: i, y: i)&.id
        break if self.moves.find_by(x: i, y: i)&.player != current_move.player
        self.finish!(current_move.player) if i == self.size
      end
    end
    puts 'antidiag'
    if current_move.x + current_move.y == self.size + 1
      (1..self.size).each do |i|
        puts self.moves.find_by(x: i, y: (self.size + 1) - i)&.id
        break if self.moves.find_by(x: i, y: (self.size + 1) - i)&.player != current_move.player
        self.finish!(current_move.player) if i == self.size
      end
    end
  end
end
