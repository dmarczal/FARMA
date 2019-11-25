import Http from '../../../libs/Http';

export default (
  exerciseId,
  additionalPath = ''
) => {
  return new Http(`/api/exercises/${exerciseId}/questions` + additionalPath);
}
