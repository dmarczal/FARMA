import Http from '../../libs/http';

const BASE_PATH = "/api/questions";

const http = new Http();

const serializeQuestions = function (data) {
  return { ...data, correct_answer: data.correctAnswer };
}

export const allQuestions = function () {
  http.get(BASE_PATH).then(
    (response) => console.log(response),
    (error) => console.log(error)
  );
}

export const postQuestion = function (data) {
  return new Promise((resolve, reject) => {
    http.post(`${BASE_PATH}?exercise_id=1`, serializeQuestions(data)).then(
      (response) => resolve(response),
      (error) => error.json().then((json) => reject(json))
    );
  });
}
