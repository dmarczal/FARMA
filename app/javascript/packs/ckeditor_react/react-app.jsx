import React from 'react';
import ReactDOM from 'react-dom';

import App from './app';

$(document).on('turbolinks:load', function () {
  var el = document.getElementById('ckeditor-app');

  if (el) {
    var inputName = $(el).data('input-name');
    var content = $(`[name="${inputName}"]`).val();

    ReactDOM.render(
      <App inputName={inputName} content={content} />,
      el
    );
  }
})
