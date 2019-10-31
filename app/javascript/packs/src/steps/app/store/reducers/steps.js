import * as types from '../actions';
import CRUDReducer from './CRUDReducer';

let item = {
  title: '',
  content: '',
  correct_answer: '',
  answer_tex: '',
  precision: null,
  variables: [],
}

const steps = (state = {
  items: [],
  didInvalidate: false,
  openForm: false,
  current: item,
  item,
}, action) => {
  if (action.type === types.LOAD_STEP) {
    return {
      ...state,
      current: action.current,
    };
  }

  return CRUDReducer(state, action, item, {
    LOAD:         types.LOAD_STEPS,
    FORM:         types.FORM_STEP,
    ERROR_SUBMIT: types.ERROR_SUBMIT_STEP,
    CLOSE_FORM:   types.CLOSE_FORM_STEP,
  });
}

export default steps;
