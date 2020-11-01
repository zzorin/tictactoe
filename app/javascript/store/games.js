import Vue from 'vue'

export const gamesStore = {
  state: {
    newGame: {size: 3, participant_role: 'x'},
    currentGame: {},
    games: [],
    activeGames: []
  },
  mutations: {
    clearNewGame(state) {
      Vue.set(state, 'newGame', {})
    },
    setGames(state, games) {
      state.games = games
    },
    setActiveGames(state, games) {
      state.activeGames = games
    },
    setCurrentGame(state, params) {
      let { game } = params
      state.currentGame = game
    },
    createGame(state, params) {
      let { resolve, reject } = params
      Vue.http.post('/games', params.params).then(data => {
        if (data.ok) {
          resolve(data.body)
        }
      })
    }
  },
  actions: {
    clearNewGame({ commit }) {
      commit('clearNewGame')
    },
    getGames({ commit, state }) {
      return new Promise((resolve, reject) => {
        Vue.http.get(`/games`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setGames', data.body)
          }
        })
      })
    },
    getActiveGames({ commit, state }) {
      return new Promise((resolve, reject) => {
        Vue.http.get(`/games/active_games`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setActiveGames', data.body)
          }
        })
      })
    },
    getGame({ commit, state }, params) {
      let { id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`games/${id}`, params).then(data => {
          if (data.status && data.status == 200) {
            commit('setCurrentGame', data.body)
          }
        })
      })
    },
    createGame({ commit }, params) {
      return new Promise((resolve, reject) => {
        commit('createGame', { params, resolve, reject })
      })
    },
    updateGame({ state }, params) {
      let { game } = params
      return new Promise((resolve, reject) => {
        Vue.http.put(`games/${game.id}`, params).then(data => {
          if (data.status) resolve(data.body)
        })
      })
    }
  },
  getters: {
    currentGame(state) {
      return state.currentGame
    }
  }
}
