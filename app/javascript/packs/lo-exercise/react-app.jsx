import React from 'react';
import ReactDOM from 'react-dom';

import App from './app';

$(document).on('turbolinks:load', function () {
  var el = document.getElementById('react-exercise-app');
  if (el) {
    let exerciseId = $(el).data('exercise-id');
    let teamId = $(el).data('team-id');

    ReactDOM.render(
      <App exerciseId={exerciseId} teamId={teamId} />,
      el
    );
  }
})
