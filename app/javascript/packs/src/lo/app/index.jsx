import React from 'react';
import Root from './Root';

let content = {
  type: 'Exercise',
  data: {
    position: 1,
    title: 'Exercício teste',
    content: '<p>Descrição <strong>test</strong></p>',
    steps: [
      {
        position: 1,
        title: 'Passo teste',
        content: '<p>Descrição <strong>test</strong></p>',
        variables: ['x'],
        current: {
          value: '2*x',
          correct: true,
        },
        responses: [
          {
            value: '3*x',
            correct: false,
          }
        ],
      },
      {
        position: 2,
        title: 'Passo teste',
        content: '<p>Descrição <strong>test</strong></p>',
        variables: ['x'],
        current: {
          value: '2*x',
          correct: false,
        },
        responses: [],
      },
      {
        position: 3,
        title: 'Passo teste',
        content: '<p>Descrição <strong>test</strong></p>',
        variables: ['x'],
        current: null,
        responses: [],
      }
    ],
  },
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
