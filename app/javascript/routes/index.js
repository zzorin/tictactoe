import Dashboard from 'components/dashboard'
import GamesIndex from 'components/games/index'
import GameShow from 'components/games/show'

export const routes = [
  {
    name: 'dashboard',
    path: '/',
    component: Dashboard,
    props: true,
    children: [
      {
        name: 'games',
        path: 'games',
        component: GamesIndex,
        children: [
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
