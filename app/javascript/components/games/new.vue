<template>
  <div>
    <div v-if='isCurrentPage("games")' class="contests-list margin-bottom-40">
      <h1>Список конкурсов</h1>
      <template v-if='access_rules.contests.new'>
        <button type="button"
                class='btn btn-blue mt-3'>
          Добавить конкурс
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

  }
</script>
