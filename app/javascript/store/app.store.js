export const SET_PER_PAGE = 'SET PER PAGE';
export const SET_LOCALE = 'SET LOCALE';

export const appStore = {
  state: {
    perPage: 20,
    locale: 'en'
  },
  mutations: {
    [SET_PER_PAGE] (state, amt) {
      state.perPage = amt;
    },
    [SET_LOCALE](state, locale) {
      state.locale = locale;
    }
  }
}
