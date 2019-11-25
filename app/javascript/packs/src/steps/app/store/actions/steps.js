import iziToast from 'izitoast';
import httpFactory from '../http-factory';
import {
  LOAD_STEPS,
  LOAD_STEP,
  FORM_STEP,
  CLOSE_FORM_STEP,
  ERROR_SUBMIT_STEP,
  invalidateLoad,
  validateLoad,
  isFetching,
  stopFetching,
 } from './index';

const getExerciseId = ({ requestLoad }) => requestLoad.exerciseId

const loadSteps = (items) => ({
  type: LOAD_STEPS,
  items
});

const loadStep = (current) => ({
  type: LOAD_STEP,
  current
});

export const formStep = (data = {}) => ({
    type: FORM_STEP,
    data: {
      title: '',
      content: '',
      correct_answer: '',
      answer_tex: '',
      precision: null,
      variables: [],
      ...data
    },
});

const errorForm = (data) => ({
  type: ERROR_SUBMIT_STEP,
  data
});

export const closeForm = () => ({
  type: CLOSE_FORM_STEP,
});

export const fetchStep = (stepId) => async (dispatch, getState) => {
  let http = httpFactory(getExerciseId(getState()));

  dispatch(isFetching());

  return http.get('/'+stepId)
    .then(({ data }) => {
      dispatch(loadStep(data));
      dispatch(stopFetching());
    }).catch(response => console.log(response));
}

export const fetchSteps = () => async (dispatch, getState) => {
  let http = httpFactory(getExerciseId(getState()));

  dispatch(isFetching());

  return http.get('/')
    .then(({ data }) => {
      dispatch(loadSteps(data));
      dispatch(stopFetching());
    }).catch(response => console.log(response));
}

export const createStep = (step) => async (dispatch, getState) => {
  let http = httpFactory(getExerciseId(getState()));
  let data = {...step};
  delete data.id;

  dispatch(isFetching());

  return http.post('/', data)
    .then(() => {
      iziToast.success({
        title: 'Passo criado com sucesso',
        position: 'topRight',
      });
      dispatch(validateLoad());
      dispatch(closeForm());
      dispatch(fetchSteps());
    }).catch((err) => {
      let { error_type, error } = err.data;
      iziToast.error({
        title: 'Erro ao tentar criar um passo',
        position: 'topRight',
      });
      dispatch(invalidateLoad(error_type, error));
      dispatch(errorForm(step));
      dispatch(stopFetching());
    });
}

export const editStep = (step) => async (dispatch, getState) => {
  let http = httpFactory(getExerciseId(getState()));
  let data = {...step};
  delete data.id;

  dispatch(isFetching());

  return http.put('/'+step.id, data)
    .then(() => {
      iziToast.success({
        title: 'Passo editado com sucesso',
        position: 'topRight',
      });
      dispatch(validateLoad());
      dispatch(closeForm());
      dispatch(fetchSteps());
    }).catch((err) => {
      let { error_type, error } = err.data;
      iziToast.error({
        title: 'Erro ao tentar editar um passo',
        position: 'topRight',
      });
      dispatch(invalidateLoad(error_type, error));
      dispatch(errorForm(step));
      dispatch(stopFetching());
    });
}

export const deleteStep = (id) => async (dispatch, getState) => {
  let http = httpFactory(getExerciseId(getState()));

  dispatch(isFetching());

  return http.delete('/'+id)
    .then(() => {
      dispatch(fetchSteps());
      iziToast.success({
        title: 'Passo deletado com sucesso',
        position: 'topRight',
      });
    })
    .catch((err) => console.log(err));
}
