<template>
  <div>
    <div v-if='isCurrentPage("games")' class="contests-list margin-bottom-40">
      <h1>История игр</h1>
      <template>
              <button type="button"
              class='btn btn-blue mt-3'
              @click='createGame'>
        Новая игра
      </button>
        <router-link
                     type="button"
                     class="btn btn-blue mt-4 mb-3"
                     :to="{
                       name: 'game_new'
                     } ">
          Новая игра(не жать)
        </router-link>
      </template>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { mapState, mapMutations, mapActions } from 'vuex'

  export default {
    mixins: [CommonMixin],
    methods: {
      createGame() {
        // Вызывает `AppearanceChannel#appear(data)` на сервере.
        // this.perform("appear", { appearing_on: this.appearingOn })
        this.$cable.perform({
          channel: 'OnlineGamersChannel',
          action: 'create_game',
          data: {
             appearing_on: '11'
          }
        })
      }
    },
    created() {
      console.warn('Игры')
    }
  }
</script>
