import Http from '../../libs/http';

const http = new Http();

const BASE_PATH = (teamId, exerciseId) => `/api/team/${teamId}/exercise/${exerciseId}`;

export const getQuestions = (teamId, exerciseId) => (
  http.get(`${BASE_PATH(teamId, exerciseId)}/load_student_questions`)
)

export const createAnswer = (data, teamId, exerciseId, questionId) => (
  http.post(`${BASE_PATH(teamId, exerciseId)}/questions/${questionId}/create_answer`, data)
)
