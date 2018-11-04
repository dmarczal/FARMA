import React from 'react';
import ReactDOM from 'react-dom';

import App from './app';

$(document).on('turbolinks:load', function () {
  var el = document.getElementById('react-app');
  let exerciseId = $(el).data('exercise-id');

  if (el) ReactDOM.render(
    <App exerciseId={exerciseId} />,
    el
  );
})
