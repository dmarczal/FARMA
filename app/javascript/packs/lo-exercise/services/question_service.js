import Http from '../../libs/http';

const http = new Http();

const BASE_PATH = (teamId, exerciseId) => `/api/team/${teamId}/exercise/${exerciseId}/load_student_questions`;

export const getQuestions = (teamId, exerciseId) => (
  http.get(BASE_PATH(teamId, exerciseId))
)
