<template>
  <div>
    <div>
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <router-link :to="{name: 'games'}"
                       class="nav-link"
                       v-bind:class="{active: isCurrentPage('games')}">
            Игры
          </router-link>
        </li>
      </ul>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { NotificationsMixin } from 'mixins/notifications'
  import { mapState, mapActions } from 'vuex'
  export default {
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
    },
    channels: {
      OnlineGamersChannel: {
        connected() {
          console.log('Connected to the online gamers channel')
        },
        received(data) {
          console.log(data)
          console.log('OnlineGamersChannel: Message received')
          if (data['action'] == 'create_game' && !this.isCurrentPage('game_show')) {
            this.notificate({
              title: 'Новая игра',
              text: data['game_id'],
              type: 'success'
            })
          }
          this.selfGetActiveGames()
        }
      }
    },
    methods: {
      ...mapActions('games', ['getActiveGames']),
      selfGetActiveGames() {
        this.getActiveGames()
      }
    },
    created() {
      console.log('Dashboard')
      this.$cable.connection.connect(
        `/cable?uid=${this.$store.getters['common/user']['id']}&access_token=${this.$store.getters['common/authenticity_token']}`
      )
      this.$cable.subscribe({
        channel: 'OnlineGamersChannel'
      })
      if (this.isCurrentPage('dashboard')) {
        this.$router.push(`games`)
      }
    }
  }
</script>
