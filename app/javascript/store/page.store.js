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

// http://localhost:3000/api/v1/page?page[number]=1&page[size]=10&sort[key]=created_at&sort[desc]=true&filters[end_date]=&filters[id]=&filters[image_file_name]=&filters[start_date]=&filters[title]=
// http://localhost:3000/api/v1/page?page[number]=1&page[size]=10&sort[key]=id&sort[desc]=false&filters[end_date]=&filters[id]=&filters[image_file_name]=&filters[start_date]=&filters[title]=
