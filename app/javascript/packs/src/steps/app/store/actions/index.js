/** Steps actions */
export const LOAD_STEPS = 'LOAD_STEPS';
export const LOAD_STEP = 'LOAD_STEP';
export const FORM_STEP = 'FORM_STEP';
export const CLOSE_FORM_STEP = 'CLOSE_FORM_STEP';
export const ERROR_SUBMIT_STEP = 'ERROR_SUBMIT_STEP';

/** Tips actions */
export const LOAD_TIPS = 'LOAD_TIPS';
export const FORM_TIP = 'FORM_TIP';
export const CLOSE_FORM_TIP = 'CLOSE_FORM_TIP';
export const ERROR_SUBMIT_TIP = 'ERROR_SUBMIT_TIP';

/** request actions */
export const INVALIDATE_LOAD = 'INVALIDATE_LOAD';
export const LOAD_EXERCISE = 'LOAD_EXERCISE';
export const VALIDATE_LOAD = 'VALIDATE_LOAD';
export const IS_FETCHING = 'IS_FETCHING';
export const STOP_FETCHING = 'STOP_FETCHING';

export const isFetching = () => ({ type: IS_FETCHING });
export const stopFetching = () => ({ type: STOP_FETCHING });

export const invalidateLoad = (message = '', errors = []) => ({
  type: INVALIDATE_LOAD,
  message,
  errors,
});

export const validateLoad = () => ({
  type: VALIDATE_LOAD,
});

export const loadExercise = (exerciseId) => ({
  type: LOAD_EXERCISE,
  exerciseId,
});
