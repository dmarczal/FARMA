import React from 'react';
import ReactDOM from 'react-dom';

import Question from './question';

const App = () => (
  <Question />
)

$(document).ready(function () {
  var el = document.getElementById('react-app');
  if (el) ReactDOM.render(<App />, el);
})
