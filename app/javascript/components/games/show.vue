<template>
  <div>
    <button type="button"
            class='btn btn-blue"'
            @click='selfUpdateGame'
            v-if="currentGame.state == 'created'">
      Присоединиться к игре
    </button>

    <table class="table-auto" v-if="currentGame.state == 'started'">
      <tr v-for='row in currentGame.size'>
        <td class="border px-4 py-2" v-for='col in currentGame.size' :id="row+'_'+col" @click='makeMove($event, row, col)'>
        </td>
      </tr>
    </table>

    <table class="table-auto">
      <tr v-for='participant in participants'>
        <td>
          {{participant}}
        </td>
      </tr>
    </table>

    {{currentParticipant}}

  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { mapState, mapGetters, mapActions } from 'vuex'

  export default {
    mixins: [CommonMixin],
    channels: {
      GameChannel: {
        connected() {
          console.log('Connected to the game channel')
          // this.install()
          // this.update()
        },
        received(data) {
          console.log(data)
          console.log('Message received')
          if (data['action'] == 'start_game') {
            this.selfGetGame()
          }
          if (data['action'] == 'make_move') {
            document.getElementById(data['coordinate']).innerHTML = data['participant_role']
          }
        }
      }
    },
    computed: {
      ...mapState( 'games', ['currentGame']),
      ...mapState( 'participants', ['participants', 'currentParticipant']),
      ...mapGetters('common', ['user']),
      id() {
        return this.$route.params.id
      }
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
        let params = { game: {id: this.currentGame.id, participants_attributes: [{role: 'o', user_id: this.user.id}]} }
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
            this.selfGetParticipants()
            this.startGame()
          }

        })
      },
      startGame() {
        console.log('startGame')
        this.$cable.perform({
          channel: 'GameChannel',
          action: 'start_game',
          data: {
             game_id: this.currentGame.id
          }
        })
      },
      makeMove(event, x, y) {
        console.log('move')
        console.log(event)
        if (event.target.innerHTML == '') {
          // event.target.innerHTML = 'x'
          this.$cable.perform({
            channel: 'GameChannel',
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
        channel: 'GameChannel'
      })
    }
  }
</script>
