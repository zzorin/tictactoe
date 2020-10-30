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

    event :complete do
      transitions from: :started, to: :finished
    end
  end
end
