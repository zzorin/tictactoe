json.array! @participants do |participant|
  json.id participant.id
  json.user_id participant.user_id
  json.game_id participant.game_id
  json.role participant.role
  json.user_email participant.user.email
end
