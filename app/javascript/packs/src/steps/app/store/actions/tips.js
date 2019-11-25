import iziToast from 'izitoast';
import httpFactory from '../http-factory';
import { fetchStep } from './steps';
import {
  LOAD_TIPS,
  FORM_TIP,
  CLOSE_FORM_TIP,
  ERROR_SUBMIT_TIP,
  invalidateLoad,
  validateLoad,
  isFetching,
  stopFetching,
} from './index';

const getExerciseId = ({ requestLoad }) => requestLoad.exerciseId;
const getHttp = (stepId, exerciseId) => httpFactory(exerciseId, `/${stepId}/tips`);

const loadTips = (items) => ({
  type: LOAD_TIPS,
  items
});

export const formTip = (data = {}) => ({
  type: FORM_TIP,
  data: {
    content: '',
    number_of_tries: 1,
    ...data
  },
});

const errorForm = (data) => ({
  type: ERROR_SUBMIT_TIP,
  data
});

export const closeForm = () => ({
  type: CLOSE_FORM_TIP,
});

export const fetchTips = (stepId) => async (dispatch, getState) => {
  let http = getHttp(stepId, getExerciseId(getState()));
  dispatch(isFetching());

  return http.get('/')
    .then(({ data }) => {
      dispatch(loadTips(data));
      dispatch(fetchStep(stepId));
    }).catch(response => console.log(response));
}

export const createTip = (stepId, tip) => async (dispatch, getState) => {
  let http = getHttp(stepId, getExerciseId(getState()));
  let data = {...tip};
  delete data.id;

  dispatch(isFetching());

  return http.post('/', data)
    .then(() => {
      iziToast.success({
        title: 'Dica criada com sucesso',
        position: 'topRight',
      });
      dispatch(validateLoad());
      dispatch(closeForm());
      dispatch(fetchTips(stepId));
    }).catch((err) => {
      let { error_type, error } = err.data;
      iziToast.error({
        title: 'Erro ao tentar criar uma dica',
        position: 'topRight',
      });
      dispatch(invalidateLoad(error_type, error));
      dispatch(errorForm(tip));
      dispatch(stopFetching());
    });
}

export const editTip = (stepId, tip) => async (dispatch, getState) => {
  let http = getHttp(stepId, getExerciseId(getState()));
  let data = {...tip};
  delete data.id;

  dispatch(isFetching());

  return http.put('/'+tip.id, data)
    .then(() => {
      iziToast.success({
        title: 'Dica editado com sucesso',
        position: 'topRight',
      });
      dispatch(validateLoad());
      dispatch(closeForm());
      dispatch(fetchTips(stepId));
    }).catch((err) => {
      let { error_type, error } = err.data;
      iziToast.error({
        title: 'Erro ao tentar editar a dica',
        position: 'topRight',
      });
      dispatch(invalidateLoad(error_type, error));
      dispatch(errorForm(tip));
      dispatch(stopFetching());
    });
}

export const deleteTip = (stepId, id) => async (dispatch, getState) => {
  let http = getHttp(stepId, getExerciseId(getState()));

  dispatch(isFetching());

  return http.delete('/'+id)
    .then(() => {
      dispatch(fetchTips(stepId));
      iziToast.success({
        title: 'Dica deletada com sucesso',
        position: 'topRight',
      });
    })
    .catch((err) => console.log(err));
}

