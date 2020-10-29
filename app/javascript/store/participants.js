import Vue from 'vue'

export const participantsStore = {
  state: {
    newParticipant: {},
    currentParticipant: {},
    participants: []
  },
  mutations: {
    clearNewParticipant(state) {
      Vue.set(state, 'newParticipant', {})
    },
    setParticipants(state, participants) {
      state.participants = participants
    },
    setCurrentParticipant(state, params) {
      let { participant } = params
      state.currentParticipant = participant
    },
    createParticipant(state, params) {
      let { resolve, reject } = params
      Vue.http.post(`games/${params.params.game_id}/participants`, params.params).then(data => {
        if (data.ok) {
          resolve(data.body)
        }
      })
    }
  },
  actions: {
    clearNewParticipant({ commit }) {
      commit('clearNewParticipant')
    },
    getParticipants({ commit, state }, params) {
      let { game_id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`games/${game_id}/participants`).then(data => {
          if (data.ok && data.status == 200) {
            commit('setParticipants', data.body)
          }
        })
      })
    },
    getParticipant({ commit, state }, params) {
      let { id } = params
      return new Promise((resolve, reject) => {
        Vue.http.get(`participants/${id}`, params).then(data => {
          if (data.status && data.status == 200) {
            commit('setCurrentParticipant', data.body)
          }
        })
      })
    },
    createParticipant({ commit }, params) {
      return new Promise((resolve, reject) => {
        commit('createParticipant', { params, resolve, reject })
      })
    },
    updateParticipant({ state }, params) {
      let { participant } = params
      return new Promise((resolve, reject) => {
        Vue.http.put(`games/${participant.game_id}/participants/${participant.id}`, params).then(data => {
          if (data.status) resolve(data.body)
        })
      })
    }
  },
  getters: {
    currentParticipant(state) {
      return state.currentParticipant
    }
  }
}
