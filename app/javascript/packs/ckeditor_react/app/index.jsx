import React from 'react';

import CKEditor from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
require('@ckeditor/ckeditor5-build-classic/build/translations/pt-br');

const App = ({ inputName, content }) => (
  <CKEditor
    editor={ ClassicEditor }
    data={content}
    config={{
      language: 'pt-br',
      cloudServices: {
        tokenUrl: 'https://35711.cke-cs.com/token/dev/dXY3KdXENvQaOivGvYxS2qs7ymMl6LE7pQa2XxQICgedXvl6HgfkJOhIlYJw',
        uploadUrl: 'https://35711.cke-cs.com/easyimage/upload/'
      }
    }}
    onChange={ ( event, editor ) => $(`[name="${inputName}"]`).val(editor.getData()) }
  />
);

export default App;
