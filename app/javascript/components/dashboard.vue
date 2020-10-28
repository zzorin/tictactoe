<template>
  <div>
    <div>
      <ul class="flex border-b" role="tablist">
        <li class="-mb-px mr-1">
             <router-link :to="{name: 'games'}"
                          class="bg-white inline-block py-2 px-4 text-blue-500 hover:text-blue-800 font-semibold"
                          v-bind:class="{active: isCurrentPage('games')}">
               Игры
             </router-link>
        </li>
      </ul>
    </div>
    <router-view></router-view>
  </div>
</template>

<style>
  .active {
    @apply bg-white inline-block border-l border-t border-r rounded-t py-2 px-4 text-blue-700 font-semibold;
  }
</style>

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
