import Vue from 'vue'

export const commonStore = {
  state: {
    localization: {},
    authenticity_token: '',
    user: {}
  },
  actions: {
    setLocalization({ commit, state }) {
      Vue.http.get('/api/v1/localization').then(data => {
        Vue.set(state, 'localization', data.body.locale)
      })
    },
    setAuthenticityToken({ commit, state }) {
      let at = document.querySelector("meta[name='csrf-token']").getAttribute('content')
      console.log('setAuthenticityToken')
      console.log(at)
      Vue.set(state, 'authenticity_token', at)
    },
    setUser({ commit, state }, user) {
      Vue.set(state, 'user', user)
    },
    setAccessRules({ commit, state }, access_rules) {
      Vue.set(state, 'access_rules', access_rules)
    },
    logger({ state }, params = {}) {
      let { skipClear, message } = params
      if (!skipClear) console.clear()
      console.warn(message)
    },
  },
  getters: {
    authenticity_token(state) {
      return state.authenticity_token
    },
    user(state) {
      return state.user
    },
    access_rules(state) {
      return state.access_rules
    },
    localization(state) {
      return state.localization
    }
  }
}
