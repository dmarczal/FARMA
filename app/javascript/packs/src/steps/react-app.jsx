import React from 'react';
import ReactDOM from 'react-dom';

import App from './app';

$(document).on('turbolinks:load', function () {
  var el = document.getElementById('steps-app');

  if (el) {
    var exerciseId = parseInt($(el).data('exercise-id'));

    ReactDOM.render(
      <App
        exerciseId={exerciseId}
      />,
      el
    );
  }
})
