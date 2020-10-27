<template>
  <div>
    <div v-if='isCurrentPage("games")' class="contests-list margin-bottom-40">
      <h1>История игр</h1>
      <template>
        <button type="button"
                class='btn btn-blue mt-3'>
          Новая игра
        </button>
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
  }
</script>
