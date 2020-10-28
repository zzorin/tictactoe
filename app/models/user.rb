class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :permissions
  has_many :participants

  def appear(on)
    puts 'appear'
    puts on
  end

  def disappear
    puts 'disappear'
  end
end
