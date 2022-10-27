import axios from 'axios'
import doAsync from './async-util'
import * as types from './mutation-types'

export const getAsync = (store) => {
  doAsync(store, {
    url: 'https://jsonplaceholder.typicode.com/posts/1',
    mutationTypes: types.GET_INFO_ASYNC
  })
}

export const fetchApiData = (store) => {
  // sets `state.loading` to true. Show a spinner or something.
  store.commit('API_DATA_PENDING')

  return axios.get('someExternalService')
    .then(response => {
      // sets `state.loading` to false
      // also sets `state.apiData to response`
      store.commit('API_DATA_SUCCESS', response.data)
    })
    .catch(error => {
      // set `state.loading` to false and do something with error

      store.commit('API_DATA_FAILURE', error)
    })
}
