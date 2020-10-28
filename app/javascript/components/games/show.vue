<template>
  <div>
    <table>
      <tr v-for='row in currentGame.size'>
        <td v-for='col in currentGame.size'>
          1
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
    },
    created() {
      console.warn('Новая игра')
      this.selfGetGame()
    }
  }
</script>
