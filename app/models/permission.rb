class Permission < ApplicationRecord
  belongs_to :user
  ROLES = %i(administrator player).freeze
end
