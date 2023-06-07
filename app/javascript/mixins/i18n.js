export default {
  methods: {
    translate: (...args) => I18n.t(...args),
    currentLocale: () => I18n.currentLocale()
  }
}
