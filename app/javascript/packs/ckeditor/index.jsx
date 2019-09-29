import React from 'react';
import PropTypes from 'prop-types';
import CKEditor from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
require('@ckeditor/ckeditor5-build-classic/build/translations/pt-br');

const App = ({
  content,
  onChange
}) => (
  <CKEditor
    editor={ ClassicEditor }
    data={content}
    config={{
      ckfinder: {
        uploadUrl: '/api/gallery'
      },
      language: 'pt-br'
    }}
    onChange={ ( event, editor ) => onChange(editor.getData()) }
  />
);

App.propTypes = {
  content: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
}

export default App;
