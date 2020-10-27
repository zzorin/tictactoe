export const NotificationsMixin = {
  methods: {
    notificate(params) {
      let { type, title, text, duration } = params
      this.$notify({
        type: type,
        title: title,
        text: text,
        group: "notifications",
        position: 'bottom right',
        duration: duration
      })
    }
  }
}
