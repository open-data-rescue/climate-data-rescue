import axios from 'axios'

const doAsync = (store, { url, mutationTypes, stateKey }) => {
  store.commit(mutationTypes.PENDING)

  setTimeout(() => {
    axios(url, {})
      .then(response => {
        store.commit(mutationTypes.SUCCESS, response.data)
      })
      .catch(error => {
        store.commit(mutationTypes.FAILURE, error)
      })
  }, 1500)
}

export default doAsync
