import * as types from '../actions';

const requestLoad = (state = {
  didInvalidate: false,
  exerciseId: null,
  message: null,
  errors: {},
  isFetching: false,
}, action) => {
  switch (action.type) {
    case types.IS_FETCHING:
      return {
        ...state,
        isFetching: true,
      };
    case types.STOP_FETCHING:
      return {
        ...state,
        isFetching: false,
      };
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

export default requestLoad;
