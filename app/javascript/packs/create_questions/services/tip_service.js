import Http from '../../libs/http';

const BASE_PATH = (exerciseId, questionId) =>
  `/api/questions/${questionId}/tips?exercise_id=${exerciseId}`;

const TIP_PATH = (exerciseId, questionId, tipId) =>
  `/api/questions/${questionId}/tips/${tipId}?exercise_id=${exerciseId}`;

const http = new Http();

const serializeTips = function (data) {
  return { ...data, number_of_tries: data.numberOfTries };
}

export const allTips = (exerciseId, questionId) => (
  http.get(BASE_PATH(exerciseId, questionId))
)

export const postTip = (data, exerciseId, questionId) => (
  http.post(BASE_PATH(exerciseId, questionId), serializeTips(data))
)

export const putTip = (data, exerciseId, questionId, tipId) => (
  http.put(TIP_PATH(exerciseId, questionId, tipId), serializeTips(data))
)

export const deleteTip = (exerciseId, questionId, tipId) => (
  http.delete(TIP_PATH(exerciseId, questionId, tipId))
)
