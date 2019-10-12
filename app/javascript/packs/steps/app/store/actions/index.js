/** Steps actions */
export const LOAD_STEPS = 'LOAD_STEPS';
export const REQUEST_STEPS = 'REQUEST_STEPS';
export const FORM_STEP = 'FORM_STEP';
export const CLOSE_FORM_STEP = 'CLOSE_FORM_STEP';
export const ERROR_SUBMIT_STEP = 'ERROR_SUBMIT_STEP';

/** request actions */
export const INVALIDATE_LOAD = 'INVALIDATE_LOAD';
export const LOAD_EXERCISE = 'LOAD_EXERCISE';
export const VALIDATE_LOAD = 'VALIDATE_LOAD';

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
