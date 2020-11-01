<template>
  <div>
    <div v-if='isCurrentPage("games")'>
      <form class="form-inline mt-2"">
        <div class="form-group mr-2">
          <label for="newGameSize">Размер поля</label>
          <select class="form-control ml-1" id="newGameSize" v-model='newGame.size'>
            <option v-for='size in fieldSizes()'>
              {{ size }}
            </option>
          </select>
        </div>
        <div class="form-check mr-2">
          <input class="form-check-input" type="radio" id="newGameX" value="x" v-model='newGame.participant_role'>
          <label class="form-check-label" for="newGameX">
            x
          </label>
        </div>
        <div class="form-check mr-2">
          <input class="form-check-input" type="radio" id="newGameO" value="o" v-model='newGame.participant_role'>
          <label class="form-check-label" for="newGameO">
            o
          </label>
        </div>
        <button type="button" class="btn btn-primary mr-2" @click='selfCreateGame()' :disabled='!(newGame.size && newGame.participant_role)'>Новая игра</button>
      </form>
      <div class="">
        <h3>Активные игры:</h3>
        <table class="table">
          <thead>
            <tr>
              <th>Размер поля</th>
              <th>Игрок</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for='game in activeGames'>
              <td>{{game.size}}</td>
              <td>
                {{ game.creator_email }} - {{ game.creator_role }}
              </td>
              <td>
                <router-link :to="{name: 'game_show', params: {id: game.id}}">
                  Подключиться
                </router-link>
              </td>
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
  import { mapState, mapGetters, mapActions } from 'vuex'

  export default {
    mixins: [CommonMixin, NotificationsMixin],
    computed: {
      ...mapState( 'games', ['games', 'newGame', 'activeGames']),
      ...mapGetters('common', ['user'])
    },
    methods: {
      ...mapActions('games', ['clearNewGame', 'getGames', 'getActiveGames', 'createGame']),
      fieldSizes() {
        return Array(8).fill().map((_, i) => i + 3)
      },
      selfGetGames() {
        this.getGames()
      },
      selfGetActiveGames() {
        this.getActiveGames()
      },
      selfCreateGame() {
        let params = {
          game: {
            size: this.newGame.size,
            participants_attributes: [
              {
                role: this.newGame.participant_role,
                user_id: this.user.id
              }
            ]
          }
        }
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
            this.broadcastGame(data.id)
            this.clearNewGame()
            this.$router.push(`games/${data.id}`)
          }
        })
      },
      broadcastGame(game_id) {
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
      this.selfGetActiveGames()
    }
  }
</script>
