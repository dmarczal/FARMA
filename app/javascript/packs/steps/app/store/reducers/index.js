import { combineReducers } from 'redux';
import * as types from '../actions';

let item = {
  title: '',
  content: '',
  correct_answer: '',
  answer_tex: '',
  precision: null,
  variables: [],
}

const requestLoad = (state = {
  didInvalidate: false,
  exerciseId: null,
  message: null,
  errors: {},
}, action) => {
  switch (action.type) {
    case types.LOAD_EXERCISE:
      return {
        ...state,
        exerciseId: action.exerciseId,
      };
    case types.VALIDATE_LOAD:
      return {
        ...state,
        didInvalidate: false,
        message: null,
        errors: {},
      };
    case types.INVALIDATE_LOAD:
      return {
        ...state,
        didInvalidate: true,
        message: action.message,
        errors: action.errors,
      };
    default:
      return state;
  }
}

const steps = (state = {
  items: [],
  isFetching: false,
  didInvalidate: false,
  openForm: false,
  item,
}, action) => {
  switch (action.type) {
    case types.REQUEST_STEPS:
      return {
        ...state,
        isFetching: true,
      }
    case types.LOAD_STEPS:
      return {
        ...state,
        items: action.items,
        isFetching: false,
      };
    case types.FORM_STEP:
      return {
        ...state,
        openForm: true,
        item: action.data,
      };
    case types.ERROR_SUBMIT_STEP:
      return {
        ...state,
        openForm: true,
        item: action.data,
        isFetching: false,
      };
    case types.CLOSE_FORM_STEP:
      return {
        ...state,
        openForm: false,
        item,
      };
    default:
      return state;
  }
}

const rootReducer = combineReducers({
  steps,
  requestLoad,
});

export default rootReducer
