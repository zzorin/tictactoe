<template>
  <div>
      <div v-if='isCurrentPage("dashboard")' class='mt-3 user-nav'>
        <router-link :to="{name: 'contests'}">Конкурсы</router-link>
        <router-link :to="{name: 'permissions'}"
                     v-if='access_rules.permissions.manage'>
          Права доступа
        </router-link>
      </div>
    <router-view></router-view>
  </div>
</template>

<script>
  import { CommonMixin } from 'mixins/common'
  export default {
    mixins: [CommonMixin],
    computed: {
    }
  }
</script>
