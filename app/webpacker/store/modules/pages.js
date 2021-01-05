import axios from 'axios'

// initial state
const state = {
  pages: [],
  current_page: {}
}

// getters
const getters = {
}

// actions
const actions = {
  // deletePage ({ dispatch }, params) {
  //   return new Promise((resolve, reject) => {
  //     axios.delete(`/api/v1/pages/${params.id}`)
  //       .then(() => {
  //         dispatch('getAccount', { account_id: params.account_id }, { root: true })
  //         resolve()
  //       })
  //       .catch((response) => {
  //         reject(response)
  //       })
  //   })
  // },
  getPages ({ commit }, params) {
    return new Promise((resolve, reject) => {
      axios.get(
        `/api/v1/pages`,
        {
          params: params
        }
      )
        .then(({ data }) => {
          commit('SET_PAGES', data)
          resolve(data)
        })
        .catch(({ response }) => {
          reject(response)
        })
    })
  }
  // getPage ({ commit }, params) {
  //   return new Promise((resolve, reject) => {
  //     axios.get(`/api/v1/pages/${params.id}`)
  //       .then(({ data }) => {
  //         commit('SET_CURRENT_PAGE', data)
  //         resolve()
  //       })
  //       .catch((response) => {
  //         reject(response)
  //       })
  //   })
  // },
  // postPage ({ dispatch }, params) {
  //   return new Promise((resolve, reject) => {
  //     axios.post(
  //       `/api/v1/pages`,
  //       params.formData
  //     ).then(() => {
  //       resolve()
  //     }).catch((response) => {
  //       reject(response)
  //     })
  //   })
  // },
  // putPage ({ dispatch }, params) {
  //   return new Promise((resolve, reject) => {
  //     axios.put(
  //       `/api/v1/pages/${params.id}`,
  //       params.formData
  //     ).then(() => {
  //       commit('SET_CURRENT_PAGE', data)
  //       resolve()
  //     }).catch((response) => {
  //       reject(response)
  //     })
  //   })
  // }
}

// mutations
const mutations = {
  SET_PAGES (state, pages) {
    state.pages = pages
  },
  SET_CURRENT_PAGE (state, page) {
    state.current_page = page
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
