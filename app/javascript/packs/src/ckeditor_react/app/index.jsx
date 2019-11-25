import React from 'react';
import CKEditor from '../../ckeditor';

const App = ({ inputName, content }) => (
  <CKEditor
    content={content}
    onChange={(data) => $(`[name="${inputName}"]`).val(data)}
  />
);

export default App;
