import * as types from '../actions';
import CRUDReducer from './CRUDReducer';

let item = {
  id: null,
  content: '',
  number_of_tries: 0,
}

const tips = (state = {
  items: [],
  didInvalidate: false,
  openForm: false,
  item,
}, action) => {
  return CRUDReducer(state, action, item, {
    LOAD:         types.LOAD_TIPS,
    FORM:         types.FORM_TIP,
    ERROR_SUBMIT: types.ERROR_SUBMIT_TIP,
    CLOSE_FORM:   types.CLOSE_FORM_TIP,
  });
}

export default tips;
