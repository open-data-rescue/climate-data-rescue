// export const MAGICAL_RELOAD = 'MAGICAL RELOAD'
export const SET_PER_PAGE = 'SET PER PAGE';
// export const SET_SPINNER = 'SET SPINNER';

export const appStore = {
  state: {
    // magicalReload: 0,
    // reloadedAt: new Date(),
    // wholePageSpinner: false,
    perPage: 20
  },
  mutations: {
    // [MAGICAL_RELOAD] (state) {
    //   state.magicalReload += 1;
    //   state.reloadedAt = new Date();
    // },
    [SET_PER_PAGE] (state, amt) {
      state.perPage = amt;
    }
    // [SET_SPINNER] (state, spinner) {
    //   state.wholePageSpinner = spinner;
    // }
  }
}
