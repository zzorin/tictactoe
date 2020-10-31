json.game do
  json.id @game.id
  json.size @game.size
  json.state @game.aasm_state
  json.winner @game.winner
  json.participants do
    json.array! @game.participants do |participant|
        json.call(participant, :id, :user_id, :role)
    end
  end
end
