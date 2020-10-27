<template>
  <div>
      <div v-if='isCurrentPage("dashboard")' class='mt-3 user-nav'>
        <router-link :to="{name: 'contests'}">Конкурсы</router-link>
        <!-- <router-link :to="{name: 'permissions'}"
                     v-if='access_rules.permissions.manage'> -->
          Права доступа
        </router-link>
      </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { NotificationsMixin } from 'mixins/notifications'
  export default {
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
    },
    channels: {
      OnlineGamersChannel: {
        connected() {
          console.log('Connected to the chat channel')
          // this.install()
          // this.update()
        },
        received(data) {
          console.log(data)
          console.log('Message received')
          this.notificate({
            title: 'Новая игра',
            text: data,
            type: 'success'
          })
        }
      }
    },
    methods: {
      install() {
        window.addEventListener("focus", this.update)
        window.addEventListener("blur", this.update)
        document.addEventListener("turbolinks:load", this.update)
        document.addEventListener("visibilitychange", this.update)
      },
      update() {
        this.documentIsActive ? this.appear() : this.away()
      },
      appear() {
        // Вызывает `AppearanceChannel#appear(data)` на сервере.
        // this.perform("appear", { appearing_on: this.appearingOn })
        this.$cable.perform({
          channel: 'OnlineGamersChannel',
          action: 'appear',
          data: {
             appearing_on: this.appearingOn
          }
        })
      },

      away() {
        // Вызывает `AppearanceChannel#away` на сервере.
        // this.perform("away")
        this.$cable.perform({
          channel: 'OnlineGamersChannel',
          action: 'away'
        })
      },
      documentIsActive() {
        return document.visibilityState == "visible" && document.hasFocus()
      },
      appearingOn() {
       const element = document.querySelector("[data-appearing-on]")
       return element ? element.getAttribute("data-appearing-on") : null
     }
    },
    created() {
      console.warn('Dashboard')
      this.$cable.connection.connect(`/cable?uid=${this.$store.getters['common/user']['id']}&access_token=${this.$store.getters['common/authenticity_token']}`)
      this.$cable.subscribe({
        channel: 'OnlineGamersChannel'
      })
    }
  }
</script>
