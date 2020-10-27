import Dashboard from 'components/dashboard'
import GamesIndex from 'components/games/index'
import GameNew from 'components/games/new'
import GameShow from 'components/games/show'
// import ContestsIndex from 'components/contests/index'
// import ContestShow from 'components/contests/show'
// import CriterionsIndex from 'components/criterions/index'
// import ParticipantsIndex from 'components/participants/index'
// import ParticipantNew from 'components/participants/new'
// import ParticipantEdit from 'components/participants/edit'
// import ExpertsIndex from 'components/experts/index'
// import ExpertNew from 'components/experts/new'
// import ExpertEdit from 'components/experts/edit'
// import MarksIndex from 'components/marks/index'
// import ResultsIndex from 'components/results/index'
// import NominationsIndex from 'components/nominations/index'
// import PermissionsIndex from 'components/permissions/index'
// import PermissionNew from 'components/permissions/new'

export const routes = [
  {
    name: 'dashboard',
    path: '/',
    component: Dashboard,
    props: true,
    children: [
      {
        name: 'games',
        path: '/',
        component: GamesIndex,
        children: [
          {
            name: 'game_new',
            path: '/games/new',
            component: GameNew
          },
          {
            name: 'game_show',
            path: '/games/:id',
            component: GameShow
          }
        ]
      }
    ]
  }
]
