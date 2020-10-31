import { commonStore } from 'store/common'
import { movesStore } from 'store/moves'
import { gamesStore } from 'store/games'
import { participantsStore } from 'store/participants'

export default {
  modules: {
    common: { namespaced: true, ...commonStore },
    games: { namespaced: true, ...gamesStore },
    participants: { namespaced: true, ...participantsStore },
    moves: { namespaced: true, ...movesStore }
  }
}
