<template>
  <div>
    <table class="table-auto">
      <tr v-for='row in currentGame.size'>
        <td class="border px-4 py-2" v-for='col in currentGame.size' :id="row+'_'+col" @click='makeMove($event, row, col)'>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { mapState, mapMutations, mapActions } from 'vuex'

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
          document.getElementById(data['coordinate']).innerHTML = data['move_type']
        }
      }
    },
    computed: {
      ...mapState( 'games', ['currentGame']),
      id() {
        return this.$route.params.id
      }
    },
    methods: {
      ...mapActions('games', ['getGame']),
      selfGetGame() {
        let params = { id: this.id }
        this.getGame(params)
      },
      makeMove(event, x, y) {
        console.log('move')
        console.log(event)
        if (event.target.innerHTML == '') {
          event.target.innerHTML = 'x'
          this.$cable.perform({
            channel: 'GameChannel',
            action: 'make_move',
            data: {
               game_id: this.currentGame.id,
               user_id: this.$store.getters['common/user']['id'],
               move_type: event.target.innerHTML,
               coordinate: event.target.id,
            }
          })
        }
      }
    },
    created() {
      console.warn('Новая игра')
      this.selfGetGame()
      this.$cable.connection.connect(`/cable?uid=${this.$store.getters['common/user']['id']}&access_token=${this.$store.getters['common/authenticity_token']}`)
      this.$cable.subscribe({
        channel: 'GameChannel'
      })
    }
  }
</script>
