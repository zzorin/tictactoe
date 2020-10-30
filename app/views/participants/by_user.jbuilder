json.participant do
  json.id @participant&.id
  json.user_id @participant&.user_id
  json.game_id @participant&.game_id
  json.role @participant&.role
end
