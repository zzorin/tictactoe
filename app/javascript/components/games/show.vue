<template>
  <div>
    <div class="d-flex align-items-center m-2"
         v-if="currentGame.state == 'created' && this.currentParticipant.id">
      <strong>Ожидание игроков...</strong>
      <div class="spinner-border ml-1" role="status" aria-hidden="true"></div>
    </div>
    <button type="button"
            class='btn btn-primary m-2'
            @click='selfUpdateGame'
            v-if="canJoinGame()">
      Присоединиться к игре
    </button>

    <h3 v-if="currentGame.state == 'finished'">
      {{getWinner()}}
    </h3>

    <div>
      <strong v-if="currentGame.state == 'started'">
        {{currentMoveType == currentParticipant.role ? 'Ваш ход' : 'Ход противника'}}
      </strong>
      <div class="row">
        <table class="table game-table col-md-6 col-md-offset-3">
          <tr v-for='row in currentGame.size'>
            <td v-bind:class="'game-size-' + currentGame.size"
                v-for='col in currentGame.size' :id="col+'_'+row"
                @click='makeMove($event, row, col)'>
            </td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { mapState, mapGetters, mapActions } from 'vuex'

  export default {
    data() {
      return {
        id: this.$route.params.id,
        currentMoveType: 'x'
      }
    },
    mixins: [CommonMixin],
    channels: {
      GamesChannel: {
        connected() {
          console.log('Connected to the game channel')
        },
        received(data) {
          console.log(data)
          console.log('Message received')
          if (data['action'] == 'start_game') {
            this.selfGetGame()
          }
          if (data['action'] == 'make_move') {
            let currentCell = document.getElementById(data['coordinate'])
            if (data['participant_role'] == 'x') {
              this.currentMoveType  = 'o'
              currentCell.className = currentCell.className + ' x-icon'
            } else {
              this.currentMoveType  = 'x'
              currentCell.className = currentCell.className + ' o-icon'
            }
            if (data['game_state'] == 'finished') {
              this.$set(this.currentGame, 'state', data['game_state'])
              this.$set(this.currentGame, 'winner', data['game_winner'])
            }
          }
        }
      }
    },
    computed: {
      ...mapState( 'games', ['currentGame']),
      ...mapState( 'participants', ['participants', 'currentParticipant']),
      ...mapGetters('common', ['user'])
    },
    methods: {
      ...mapActions('games', ['getGame', 'updateGame']),
      ...mapActions('participants', ['getParticipants', 'getParticipant']),
      selfGetGame() {
        let params = { id: this.id }
        this.getGame(params)
      },
      selfGetParticipant() {
        let params = { game_id: this.id, user_id: this.user.id }
        this.getParticipant(params)
      },
      selfGetParticipants() {
        let params = { game_id: this.id }
        this.getParticipants(params)
      },
      selfUpdateGame() {
        console.log('selfUpdateGame')
        let exitstingParticipant = this.participants.find(participant => (participant.role == 'x' || participant.role == 'o'))
        console.log(exitstingParticipant)
        let newRole = exitstingParticipant['role'] == 'x' ? 'o' : 'x'
        let params = { game: {id: this.currentGame.id, participants_attributes: [{role: newRole, user_id: this.user.id}]} }
        this.updateGame(params).then(data => {
          if (data.status == 'error') {
            this.notificate({
              title: data.errors.title,
              text: data.errors.text,
              type: 'error'
            })
            return
          }
          if (data.status == 200) {
            this.selfGetParticipant()
            this.selfGetParticipants()
            this.startGame()
            this.broadcastGameStarting(data.id)
          }

        })
      },
      broadcastGameStarting(game_id) {
        this.$cable.perform({
          channel: 'OnlineGamersChannel',
          action: 'close_game'
        })
      },
      canJoinGame() {
        return this.currentGame.state == 'created' && !this.currentParticipant.id
      },
      getWinner() {
        return this.currentGame.winner ? `Победитель: ${this.currentGame.winner}` : 'Ничья'
      },
      startGame() {
        console.log('startGame')
        this.$cable.perform({
          channel: 'GamesChannel',
          game_id: this.id,
          action: 'start_game',
          data: {
             game_id: this.currentGame.id
          }
        })
      },
      makeMove(event, x, y) {
        console.log('move')
        if (this.currentGame.state == 'started' && event.target.innerHTML == '' && this.currentMoveType == this.currentParticipant.role) {
          this.currentMoveType = this.currentParticipant.role == 'x' ? 'o' : 'x'
          this.$cable.perform({
            channel: 'GamesChannel',
            game_id: this.id,
            action: 'make_move',
            data: {
               game_id: this.currentGame.id,
               user_id: this.user.id,
               participant_role: this.currentParticipant.role,
               // move_type: event.target.innerHTML,
               coordinate: event.target.id
            }
          })
        }
      }
    },
    created() {
      console.warn('Новая игра')
      this.selfGetGame()
      this.selfGetParticipant()
      this.selfGetParticipants()
      this.$cable.connection.connect(`/cable?uid=${this.$store.getters['common/user']['id']}&access_token=${this.$store.getters['common/authenticity_token']}`)
      this.$cable.subscribe({
        channel: 'GamesChannel',
        game_id: this.id
      })
    }
  }
</script>
