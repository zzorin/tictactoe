import Vue from 'vue'
import store from 'store/base'

export default function setup() {
  Vue.http.interceptors.push(function(request) {
    let authenticity_token = store.modules.common.state.authenticity_token
    // modify headers
    request.headers.set('X-CSRF-TOKEN', authenticity_token);
  })
}
