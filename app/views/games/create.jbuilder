json.status 200
json.id @game.id
json.partial! 'shared/notifications', model: 'game'
