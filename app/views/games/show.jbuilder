json.game do
  json.id @game.id
  json.size @game.size
  json.aasm_state @game.aasm_state
  json.participants do
    json.array! @game.participants do |participant|
        json.call(participant, :id, :user_id, :role)
    end
  end
end
