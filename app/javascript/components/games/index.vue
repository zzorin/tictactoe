<template>
  <div>
    <div v-if='isCurrentPage("games")' class="games-list margin-bottom-40">
      <h1>Игра</h1>
      <div class="">
        <div class="mb-1">
          <strong>Размер поля</strong>
          <span class="text-danger">*</span>
        </div>
        <div class="d-flex">
          <input type="text"
                 class="input-with-button form-control"
                 v-model='newGame.size'/>
        </div>
        <button type="button"
                class='btn btn-blue mt-3'
                @click='selfCreateGame'
                :disabled='!(newGame.size)'>
          Новая игра
        </button>
      </div>
      <div class="">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>SIZE</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for='game in games'>
              <td>{{game.id}}</td>
              <td>{{game.size}}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { NotificationsMixin } from 'mixins/notifications'
  import { mapState, mapMutations, mapActions } from 'vuex'

  export default {
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
      ...mapState( 'games', ['games', 'newGame'])
    },
    methods: {
      ...mapActions('games', ['clearNewGame', 'getGames', 'createGame']),
      selfGetGames() {
        // let params = {
        //   contest_id: this.currentContest.id,
        // }
        this.getGames()
      },
      selfCreateGame() {
        let params = { game: this.newGame }
        this.createGame(params).then(data => {
          if (data.status == 'error') {
            this.notificate({
              title: data.errors.title,
              text: data.errors.text,
              type: 'error'
            })
            return
          }
          if (data.status == 200) {
            // this.notificate({
            //   title: data.notifications.title,
            //   text: data.notifications.text
            // })
            this.broadcastGame(data.id)
            this.clearNewGame()
            this.$router.push(`games/${data.id}`)
          }

        })
      },
      broadcastGame(game_id) {
        // Вызывает `AppearanceChannel#appear(data)` на сервере.
        // this.perform("appear", { appearing_on: this.appearingOn })
        this.$cable.perform({
          channel: 'OnlineGamersChannel',
          action: 'create_game',
          data: {
             game_id: game_id
          }
        })
      }
    },
    created() {
      console.warn('Игры')
      this.selfGetGames()
    }
  }
</script>
