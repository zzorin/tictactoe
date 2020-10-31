import Vue from 'vue'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'
import Vuex from 'vuex'
import Notifications from 'vue-notification'
import Autocomplete from 'vuejs-auto-complete'
import Datepicker from 'vuejs-datepicker'
import Paginate from 'vuejs-paginate'
import baseStore from 'store/base'
import { routes } from 'routes/index'
import interceptorsSetup from 'interceptors'
import ActionCableVue from 'actioncable-vue'
// import './application.css'
// import VModal from 'vue-js-modal'

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

Vue.component('autocomplete', Autocomplete)
Vue.component('datepicker', Datepicker)
Vue.component('paginate', Paginate)

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
      // this.$cable.connection.connect(`/cable?uid=${this.$store.getters['common/user']['id']}&access_token=${this.$store.getters['common/authenticity_token']}`)
      // this.$cable.subscribe({
      //   channel: 'OnlineGamersChannel'
      // })
    }
  }).$mount('#app')
})
