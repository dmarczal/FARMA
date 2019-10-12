import React from 'react';
import { useParams } from 'react-router-dom';

export default () => {
  let { stepId } = useParams();

  return (
    <p>DICAS do passo {stepId}</p>
  );
};
