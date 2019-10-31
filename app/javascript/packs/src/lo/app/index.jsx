import React from 'react';
import Root from './Root';

let content = {
  type: 'Exercise',
  links: [
    {
      id: 'Introduction1',
      position: 1,
      type: 'Introduction',
      page: 1,
      active: true,
    },
    {
      id: 'Exercise1',
      position: 1,
      type: 'Exercise',
      page: 2,
      steps: [true, true, false, null],
      active: false,
    },
    {
      id: 'Exercise2',
      position: 2,
      type: 'Exercise',
      steps: [true, true, false, null],
      page: 3,
      active: false,
    }
  ]
};

export default () => (
  <Root content={content}/>
);
