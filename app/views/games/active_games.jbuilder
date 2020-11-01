json.array! @active_games do |game|
  json.id game.id
  json.size game.size
  json.creator_role game.participants&.players&.first&.role
  json.creator_email game.participants&.players&.first&.user&.email
end
