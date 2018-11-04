import Http from '../../libs/http';

const BASE_PATH = (exerciseId) =>  `/api/questions?exercise_id=${exerciseId}`;
const QUESTION_PATH = (questionId, exerciseId) => `/api/questions/${questionId}?exercise_id=${exerciseId}`;

const http = new Http();

export const serializeQuestions = function (data) {
  return { ...data, correct_answer: data.correctAnswer };
}

export const allQuestions = function (exerciseId) {
  return new Promise((resolve, reject) => {
    http.get(BASE_PATH(exerciseId)).then(
      (response) => resolve(response),
      (error) => error.json().then((json) => reject(json))
    );
  });
}

export const deleteQuestion = function (exerciseId, questionId) {
  return new Promise ((resolve, reject) => {
    http.delete(QUESTION_PATH(questionId, exerciseId)).then(
      (response) => resolve(response),
      (error) => error.json().then((json) => reject(json))
    );
  });
}

export const postQuestion = function (data, exerciseId) {
  return new Promise((resolve, reject) => {
    http.post(BASE_PATH(exerciseId), serializeQuestions(data)).then(
      (response) => resolve(response),
      (error) => error.json().then((json) => reject(json))
    );
  });
}
