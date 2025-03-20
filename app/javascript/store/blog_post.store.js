// 
import { NEW } from './model.store';

export const NEW_BLOG_POST = 'NEW BLOG POST';

export const blogPostModel = 'blog_post';

// /api/v1/blog_post
export const blogPostEndpoints = {
  [blogPostModel]: 'blog_post'
}

export const blogPostStore = {
  actions: {
    [NEW_BLOG_POST] ({dispatch}, attributes) {
      return dispatch(NEW, {model: blogPostModel, selected: false, ...attributes})
    },
  },
  selected: {
    [blogPostModel]: undefined
  },
  getters: {
  }
}
