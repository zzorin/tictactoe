import { commonStore } from 'store/common'
// import { permissionsStore } from 'store/permissions'
import { gamesStore } from 'store/games'
// import { criterionsStore } from 'store/criterions'
// import { participantsStore } from 'store/participants'
// import { nominationsStore } from 'store/nominations'
// import { expertsStore } from 'store/experts'
// import { marksStore } from 'store/marks'
export default {
  modules: {
    common: { namespaced: true, ...commonStore },
    // permissions: { namespaced: true, ...permissionsStore },
    games: { namespaced: true, ...gamesStore },
    // criterions: { namespaced: true, ...criterionsStore },
    // participants: { namespaced: true, ...participantsStore },
    // nominations: { namespaced: true, ...nominationsStore },
    // experts: { namespaced: true, ...expertsStore },
    // marks: { namespaced: true, ...marksStore }
  }
}
