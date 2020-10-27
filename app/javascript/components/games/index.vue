<template>
  <div>
    <div v-if='isCurrentPage("games")' class="contests-list margin-bottom-40">
      <h1>История игр</h1>
      <template>
        <router-link
                     type="button"
                     class="btn btn-blue mt-4 mb-3"
                     :to="{
                       name: 'game_new'
                     } ">
          Новая игра
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
    created() {
      console.warn('Игры')
    }
  }
</script>
