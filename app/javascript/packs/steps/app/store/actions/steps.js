import iziToast from 'izitoast';
import {
  LOAD_STEPS,
  REQUEST_STEPS,
  FORM_STEP,
  CLOSE_FORM_STEP,
  invalidateLoad,
  validateLoad,
  ERROR_SUBMIT_STEP,
 } from './index';

import httpFactory from '../http-factory';

const requestSteps = () => ({
  type: REQUEST_STEPS,
});

const loadSteps = (items) => ({
  type: LOAD_STEPS,
  items
});

const getExerciseId = ({ requestLoad }) => requestLoad.exerciseId

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

export const fetchSteps = () => async (dispatch, getState) => {
  let http = httpFactory(getExerciseId(getState()));

  dispatch(requestSteps());

  return http.get('/')
    .then(({ data }) => dispatch(loadSteps(data)))
    .catch(response => console.log(response));
}

export const createStep = (step) => async (dispatch, getState) => {
  let http = httpFactory(getExerciseId(getState()));
  let data = {...step};
  delete data.id;

  dispatch(requestSteps());

  return http.post('/', data)
    .then(() => {
      dispatch(fetchSteps());
      iziToast.success({
        title: 'Passo criado com sucesso',
        position: 'topRight',
      });
      dispatch(validateLoad());
      dispatch(closeForm());
    }).catch((err) => {
      let { error_type, error } = err.data;
      iziToast.error({
        title: 'Erro ao tentar criar um passo',
        position: 'topRight',
      });
      dispatch(invalidateLoad(error_type, error));
      dispatch(errorForm(step));
    });
}

export const editStep = (step) => async (dispatch, getState) => {
  let http = httpFactory(getExerciseId(getState()));
  let data = {...step};
  delete data.id;

  dispatch(requestSteps());

  return http.put('/'+step.id, data)
    .then(() => {
      dispatch(fetchSteps());
      iziToast.success({
        title: 'Passo editado com sucesso',
        position: 'topRight',
      });
      dispatch(validateLoad());
      dispatch(closeForm());
    }).catch((err) => {
      let { error_type, error } = err.data;
      iziToast.error({
        title: 'Erro ao tentar editar um passo',
        position: 'topRight',
      });
      dispatch(invalidateLoad(error_type, error));
      dispatch(errorForm(step));
    });
}

export const deleteStep = (id) => async (dispatch, getState) => {
  let http = httpFactory(getExerciseId(getState()));

  dispatch(requestSteps());

  return http.delete('/'+id)
    .then(() => {
      dispatch(fetchSteps())
      iziToast.success({
        title: 'Passo deletado com sucesso',
        position: 'topRight',
      });
    })
    .then((err) => console.log(err));
}
