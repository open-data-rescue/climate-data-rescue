import { NEW } from './model.store';

export const NEW_PAGE = 'NEW PAGE';

export const pageModel = 'page';

// /api/v1/pages
export const pageEndpoints = {
  [pageModel]: 'page'
}

export const pageStore = {
  actions: {
    [NEW_PAGE] ({dispatch}, attributes) {
      return dispatch(NEW, {model: pageModel, selected: false, ...attributes})
    },
  },
  selected: {
    [pageModel]: undefined
  },
  getters: {
  }
}
