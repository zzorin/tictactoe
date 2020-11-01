class Permission < ApplicationRecord
  belongs_to :user
  ROLES = %w(administrator player).freeze
end
