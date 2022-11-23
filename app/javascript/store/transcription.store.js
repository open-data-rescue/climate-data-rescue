import { NEW } from './model.store';

export const NEW_TRANSCRIPTION = 'NEW TRANSCRIPTION';

export const transcriptionModel = 'transcription';

// /api/v1/transcription
export const transcriptionEndpoints = {
  [transcriptionModel]: 'transcription'
}

export const transcriptionStore = {
  actions: {
    [NEW_TRANSCRIPTION] ({dispatch}, attributes) {
      return dispatch(NEW, {model: transcriptionModel, selected: false, ...attributes})
    },
  },
  selected: {
    [transcriptionModel]: undefined
  },
  getters: {
  }
}
