import { combineReducers } from 'redux';
import steps from './steps';
import requestLoad from './requestLoad';
import tips from './tips';

const rootReducer = combineReducers({
  steps,
  tips,
  requestLoad,
});

export default rootReducer
