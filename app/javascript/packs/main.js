import Vue from 'vue'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'
import Vuex from 'vuex'
import Notifications from 'vue-notification'
import baseStore from 'store/base'
import { routes } from 'routes/index'
import interceptorsSetup from 'interceptors'
import ActionCableVue from 'actioncable-vue'

Vue.use(VueRouter)
Vue.use(VueResource)
Vue.use(Vuex)
Vue.use(Notifications)
Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: 'error',
  connectionUrl: '/cable',
  connectImmediately: false
})

interceptorsSetup()

document.addEventListener('DOMContentLoaded', () => {
  const router = new VueRouter({
    routes
  })
  const store = new Vuex.Store(baseStore)
  const app = new Vue({
    store,
    router,
    methods: {
      initParams(params) {
        this.$store.dispatch('common/setUser', params.user)
        this.$store.dispatch('common/setAccessRules', params.access_rules)
      }
    },
    mounted() {
      this.$store.dispatch('common/setAuthenticityToken')
    }
  }).$mount('#app')
})
