<template>
  <div>
    <div v-if='isCurrentPage("game_new")' class="contests-list margin-bottom-40">
      <h1>Новая игра</h1>
      <div>
        <game-settings>
        </game-settings>
        <span class='btn btn-green'
          Сохранить
        </span>
        <span class='btn btn-light-blue'>
          Отменить
        </span>
      </div>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  import { mapState, mapMutations, mapActions } from 'vuex'
  import GameSettings from 'components/games/game-settings'

  export default {
    mixins: [CommonMixin],
    components: {
      GameSettings
    },
    created() {
      console.warn('New game')
    }
  }
</script>
