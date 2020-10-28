import { mapGetters } from 'vuex'

export const CommonMixin = {
  computed: {
    ...mapGetters('common', ['access_rules']),
  },
  methods: {
    isCurrentPage(route) {
      console.log('isCurrentPage')
      console.log(route)
      console.log(this.$route.name)
      return this.$route.name == route
    },
    redirectTo(path, id) {
      this.$router.push({ name: path, params: { id: id }})
    }
  }
}
