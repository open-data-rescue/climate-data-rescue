/*
 This exists because we need to have access to some model methods without
 needing to set the prop in the component
**/
import { utils } from 'jsonapi-vuex'

import { DELETE, SAVE, SELECT, SELECTED, FETCH, UNSELECT} from "./model.store";

export const modelUtilsMixin = {
  methods: {
    get_model(model, id) {
      let res = this.$store.getters['jv/get']({_jv: {id: id, type: model}})
      return utils.deepCopy(res)
    },
    select_model(model, itemOrId) {
      return this.$store.commit(SELECT, {model: model, itemOrId});
    },
    unselect_model(model) {
      return this.$store.commit(UNSELECT, {model: model});
    },
    selected_model(model) {
      return this.$store.getters[SELECTED]({model: model})
    },
    save_model(model, instance) {
      return this.$store.dispatch(SAVE, {model: model, selected: false, item: instance});
    },
    fetch_models(model, params, url = null) {
      return this.$store.dispatch(FETCH, {model: model, url: url, params});
    },
    delete_model_by_id(model, id) {
      return this.$store.dispatch(DELETE, {model: model, itemOrId: id})
    }
  }
}

export default modelUtilsMixin;
