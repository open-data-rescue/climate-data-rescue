import Vue from 'vue'
import Vuex from 'vuex'
import { jsonapiModule, utils } from 'jsonapi-vuex'
import { http } from '../http';
import { getId } from '../utils/jsonapi_utils';

export const SELECT = 'SELECT';
export const UNSELECT = 'UNSELECT';

export const SELECTED = 'SELECTED';
// export const FETCH_SELECTED = 'FETCH SELECTED';
// export const FETCH_BY_ID = 'FETCH BY ID'
export const FETCH = 'FETCH';
export const NEW = 'NEW';
export const SAVE = 'SAVE';
export const DELETE = 'DELETE';
export const SEARCH = 'SEARCH';
export const CLEAR = 'CLEAR';
export const SET_LOCALE = 'SET LOCALE'

// export const UPDATE_ALL = 'UPDATE ALL';
//
// export const PATCH_RELATED = 'PATCH RELATED';
// export const PATCH_FIELDS = 'PATCH FIELDS';

// global app things
import { appStore } from './app.store';

// page add-ons
import { pageStore, pageEndpoints } from './page.store';
import { transcriptionStore, transcriptionEndpoints } from './transcription.store';
import { dataEntryAuditStore, dataEntryAuditEndpoints } from './data_entry_audit.store';

import merge from 'lodash.merge'

const endpoints = {
  ...pageEndpoints,
  ...transcriptionEndpoints,
  ...dataEntryAuditEndpoints
}

// NOTE: this is really the store
Vue.use(Vuex)
export const store = new Vuex.Store({
  modules: {
    // TODO: change clearOnUpdate behavoir
    // see the following for table requests ...
    // Remove all records of type 'widget' from the store
    // store.commit('jv/clearRecords', { _jv: { type: 'widget' } })
    jv: jsonapiModule(
      http,
      {
        preserveJson: true,
        clearOnUpdate: false
      }
    )
  },
  state: {
    locale: 'en',
    selected: {
      ...pageStore.selected,
      ...transcriptionStore.selected,
      ...dataEntryAuditStore.selected
    },
    ...appStore.state
    // ...mailingStore.state
  },
  getters: {
    [SELECTED] (state, getters) {
      return ({model}) => {
        if (!state.selected[model]) return undefined;

        let res = getters['jv/get']({_jv: {id: state.selected[model], type: model}})
        if (model === surveyModel) {
          // Deepcopy is a problem for surveys ... so we only do on the select of individual component ...
          // need to also deep copy selected survey when we edit it's attributes.... how????
          return res
        } else {
          // console.debug('**** DEEP COPY ....', model)
          return utils.deepCopy(res)
        }
      }
    },
    ...pageStore.getters,
    ...transcriptionStore.getters,
    ...dataEntryAuditStore.getters
    // ...sessionLimitStore.getters,
  },
  plugins: [
    // ...surveyStore.plugins
  ],
  mutations: {
    [SELECT] (state, {model, itemOrId}) {
      state.selected[model] = getId(itemOrId);
    },
    [UNSELECT] (state, {model}) {
      state.selected[model] = undefined;
    },
    [CLEAR] (state, {model}) {
      this.commit('jv/clearRecords', { _jv: { type: model } })
    },
    [SET_LOCALE] (state, locale) {
      state.locale = locale
    },
    ...appStore.mutations
    // ...personSessionStore.mutations,
  },
  actions: {
    /**
     *
     */
    // [UPDATE_ALL] (context, {model, ids, attrs}) {
    //   const config = []
    //   const path = `/${model}/update_all`
    //   const apiConf = { method: 'post', url: path }
    //   config['data'] = {ids: ids, attrs: attrs}
    //   merge(apiConf, config)
    //
    //   // Variation of what the jsonapi-vuex does
    //   return http(
    //     apiConf
    //   ).then(
    //     (results) => {
    //       let resData = utils.jsonapiToNorm(results.data.data)
    //       // PROBLEM ????
    //       context.commit('jv/addRecords', resData)
    //       utils.processIncludedRecords(context, results)
    //       resData = utils.checkAndFollowRelationships(context.state, context.getters, resData)
    //       resData = utils.preserveJSON(resData, results.data)
    //       return resData
    //     }
    //   )
    // },

    /**
     * this method isn't in our version of jsonapi-vuex, so we're writing our own
     * right now it only works on one to many
     */
    // [PATCH_RELATED] ({dispatch}, {item, parentRelName, childIdName}) {
    //   let relId = item?._jv?.id
    //   let rels = item?._jv?.relationships?.[parentRelName]?.data
    //   if(!rels || !rels.length) {
    //     // no relationships found, what to do here? returning true for now
    //     return Promise.resolve(true)
    //   }
    //   let itemsToSend = rels.map( r => ({
    //     // TODO optimistic locking
    //     [childIdName]: relId,
    //     _jv: r
    //   }));
    //   return Promise.all(itemsToSend.map(i => dispatch('jv/patch', i)))
    // },
    /*
      NOTE: The backend will save relationship (tested when it is the 'parent')

      NOTE: the ...attrs is weird, need to do spread in the call as well ...
      Because: this means you could call [NEW]({model, selected: true, arbitrary: 'attributes' })
    */
    [NEW] ({commit, dispatch}, {model, selected = false, relationships = {}, ...attrs}) {
      let newModel = {
        ...attrs,
        _jv: {
          type: model,
          relationships
        }
      }

      return new Promise((res, rej) => {
        dispatch('jv/post', newModel).then((savedModel) => {
          if (selected) {
            commit(SELECT, {model, itemOrId: savedModel});
          }
          res(savedModel);
        }).catch(rej);
      });
    },
    [SAVE] ({commit, dispatch}, {model, selected = true, item, params}) {
      if(item._jv) {
        if(!item._jv.type) {
          _jv.type = model
        }
      }
      else {
        item._jv = { type: model }
      }

      return new Promise((res, rej) => {
        dispatch('jv/patch', [item, {params}]).then((savedModel) => {
          // to get around the fact that the getter returns a copy,
          // re-select the saved model so that the getter updates.
          if(selected) {
            commit(SELECT, {model, itemOrId: savedModel});
          }
          res(savedModel);
        }).catch(rej)
      });
    },
    [DELETE] ({dispatch, commit, state}, {model, itemOrId, unselect = true}) {
      return new Promise((res, rej) => {
        dispatch('jv/delete', `/api/v1/${endpoints[model]}/${getId(itemOrId)}`).then((data) => {
          if (unselect && state.selected[model]) {
            commit(UNSELECT, {model})
          }
          res(data)
        }).catch(rej)
      })
    },
    [SEARCH] ({dispatch}, {model, params}) {
      return dispatch('jv/search', [`/api/v1/${endpoints[model]}`, {params}])
    },
    // need a way to override the default URL
    [FETCH] ({dispatch}, {model, url = null, params}) {
      if (url) {
        return dispatch('jv/get', [url, {params}])
      } else {
        return dispatch('jv/get', [`/api/v1/${endpoints[model]}`, {params}])
      }
    },
    // [CLEAR] ({dispatch}, {model}) {
    //   this.commit('jv/clearRecords', { _jv: { type: model } })
    // },
    // [FETCH_SELECTED] ({state, dispatch}, {model}) {
    //   if (!state.selected[model]) {
    //     return Promise.reject(`No ${model} selected`)
    //   }
    //   return dispatch(FETCH_BY_ID, {model, id: state.selected[model]})
    // },
    // [FETCH_BY_ID] ({dispatch}, {model, id}) {
    //   // We do need this - not all fetch by id will be selected models
    //   return dispatch('jv/get', `${endpoints[model]}/${id}`)
    // },
    // [PATCH_FIELDS] ({dispatch, commit}, {model, item, fields=[], selected = true}) {
    //   // limited field selection
    //   let smallItem = {
    //     // always include lock version so that we have optimistic locking
    //     lock_version: item.lock_version || 0,
    //     ...fields.map(field => ({[field]: item[field]})).reduce((p, c) => ({...p, ...c}), {}),
    //     id: item.id,
    //     _jv: {
    //       type: model,
    //       id: item.id
    //     }
    //   }
    //   return new Promise((res, rej) => {
    //     dispatch('jv/patch', smallItem).then((savedModel) => {
    //       if (selected) {
    //         commit(SELECT, {model, itemOrId: savedModel});
    //       }
    //       res(savedModel);
    //     }).catch(rej);
    //   });
    // },
    ...pageStore.actions,
    ...transcriptionStore.actions,
    ...dataEntryAuditStore.actions
    // ...personSessionStore.actions,
  }
})
