import Http from '../../libs/http';

const BASE_PATH = (exerciseId) =>  `/api/questions?exercise_id=${exerciseId}`;
const QUESTION_PATH = (questionId, exerciseId) => `/api/questions/${questionId}?exercise_id=${exerciseId}`;

const http = new Http();

const serializeQuestions = function (data) {
  return { ...data, correct_answer: data.correctAnswer };
}

export const allQuestions = (exerciseId) => (
  http.get(BASE_PATH(exerciseId))
)

export const deleteQuestion = (exerciseId, questionId) => (
  http.delete(QUESTION_PATH(questionId, exerciseId))
)

export const postQuestion = (data, exerciseId) => (
  http.post(BASE_PATH(exerciseId), serializeQuestions(data))
)

export const putQuestion = (data, exerciseId, questionId) => (
  http.put(QUESTION_PATH(questionId, exerciseId), serializeQuestions(data))
)
