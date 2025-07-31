import Vue from 'vue'
import Vuex from 'vuex'
import { jsonapiModule, utils } from 'jsonapi-vuex'
import { http } from '../http';
import { getId } from '../utils/jsonapi_utils';

export const SELECT = 'SELECT';
export const UNSELECT = 'UNSELECT';

export const SELECTED = 'SELECTED';
export const FETCH = 'FETCH';
export const NEW = 'NEW';
export const SAVE = 'SAVE';
export const DELETE = 'DELETE';
export const SEARCH = 'SEARCH';
export const CLEAR = 'CLEAR';
export const PATCH_FIELDS = 'PATCH FIELDS';

// global app things
import { appStore } from './app.store';

// page add-ons
import { pageStore, pageEndpoints } from './page.store';
import { transcriptionStore, transcriptionEndpoints } from './transcription.store';
import { dataEntryAuditStore, dataEntryAuditEndpoints } from './data_entry_audit.store';
import { blogPostStore, blogPostEndpoints } from './blog_post.store';

import merge from 'lodash.merge'

const endpoints = {
  ...pageEndpoints,
  ...transcriptionEndpoints,
  ...dataEntryAuditEndpoints,
  ...blogPostEndpoints
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
      ...dataEntryAuditStore.selected,
      ...blogPostStore.selected
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
    ...dataEntryAuditStore.getters,
    ...blogPostStore.getters
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
    ...appStore.mutations
  },
  actions: {
    /*
      NOTE: The backend will save relationship (tested when it is the 'parent')

      NOTE: the ...attrs is weird, need to do spread in the call as well ...
      Because: this means you could call [NEW]({model, selected: true, arbitrary: 'attributes' })
    */
    [NEW] ({commit, dispatch, state}, {model, selected = false, relationships = {}, ...attrs}) {
      let newModel = {
        ...attrs,
        _jv: {
          type: model,
          relationships
        }
      }

      return new Promise((res, rej) => {
        dispatch('jv/post', [newModel, { url: `/${state.locale}${endpoints[model]}` }]).then((savedModel) => {
          if (selected) {
            commit(SELECT, {model, itemOrId: savedModel});
          }
          res(savedModel);
        }).catch(rej);
      });
    },
    [SAVE] ({commit, dispatch, state}, {model, selected = true, item, params}) {
      if(item._jv) {
        if(!item._jv.type) {
          _jv.type = model
        }
      }
      else {
        item._jv = { type: model }
      }

      return new Promise((res, rej) => {
        dispatch('jv/patch', [item, { params, url: `/${state.locale}${endpoints[model]}/${getId(item)}` }]).then((savedModel) => {
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
        dispatch('jv/delete', `/${state.locale}/api/v1/${endpoints[model]}/${getId(itemOrId)}`).then((data) => {
          if (unselect && state.selected[model]) {
            commit(UNSELECT, {model})
          }
          res(data)
        }).catch(rej)
      })
    },
    [SEARCH] ({dispatch, state}, {model, params}) {
      return dispatch('jv/search', [`/${state.locale}/api/v1/${endpoints[model]}`, {params}])
    },
    // need a way to override the default URL
    [FETCH] ({dispatch, state}, {model, url = null, params}) {
      if (url) {
        return dispatch('jv/get', [url, {params}])
      } else {
        console.debug("***** FETCH P", params)
        return dispatch('jv/get', [`/${state.locale}/api/v1/${endpoints[model]}`, {params}])
      }
    },
    [PATCH_FIELDS] ({dispatch, commit}, {model, item, fields=[], selected = true}) {
      // limited field selection
      let smallItem = {
        // always include lock version so that we have optimistic locking
        lock_version: item.lock_version || 0,
        ...fields.map(field => ({[field]: item[field]})).reduce((p, c) => ({...p, ...c}), {}),
        id: item.id,
        _jv: {
          type: model,
          id: item.id
        }
      }
      return new Promise((res, rej) => {
        dispatch('jv/patch', smallItem).then((savedModel) => {
          if (selected) {
            commit(SELECT, {model, itemOrId: savedModel});
          }
          res(savedModel);
        }).catch(rej);
      });
    },
    ...pageStore.actions,
    ...transcriptionStore.actions,
    ...dataEntryAuditStore.actions,
    ...blogPostStore.actions
  }
})
