import React from 'react';

import CKEditor from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
require('@ckeditor/ckeditor5-build-classic/build/translations/pt-br');

const App = ({ inputName, content }) => (
  <CKEditor
    editor={ ClassicEditor }
    data={content}
    config={{
      ckfinder: {
        uploadUrl: '/api/gallery'
      },
      language: 'pt-br'
    }}
    onChange={ ( event, editor ) => $(`[name="${inputName}"]`).val(editor.getData()) }
  />
);

export default App;
