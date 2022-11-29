// // Code from https://medium.com/@lachlanmiller_52885/a-pattern-to-handle-ajax-requests-in-vuex-2d69bc2f8984
//
// import _ from 'lodash'
//
// const createAsyncMutation = (type) => ({
//   SUCCESS: `${type}_SUCCESS`,
//   FAILURE: `${type}_FAILURE`,
//   PENDING: `${type}_PENDING`,
//   loadingKey: _.camelCase(`${type}_PENDING`),
//   stateKey: _.camelCase(`${type}_DATA`)
// })
//
// export const GET_INFO_ASYNC = createAsyncMutation('GET_INFO')
