import React from 'react';
import PropTypes from 'prop-types';
import CKEditor from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';

const isError = (error) => Array.isArray(error) && error.length > 0;
const classError = (error) => isError(error) ? 'has-error' : '';

const getError = (error) => {
  if (isError(error)) {
    return (<span className="help-block">{error[0]}</span>);
  }

  return '';
}

const Component = ({
  errors,
  content,
  numberOfTries,
  onClick,
  onClose,
  actionText,
  onChangeContent,
  onChangeNumberOfTries,
}) => (
  <React.Fragment>
    <h3 className="center-align">{actionText}</h3>
    <div className="row form">
      <div className={`input-field col s12 ${classError(errors.content)}`}>
        <CKEditor
          editor={ ClassicEditor }
          data={content}
          config={{
            language: 'pt-br'
          }}
          onChange={ ( event, editor ) => onChangeContent(editor.getData()) }
        />
        {getError(errors.content)}
      </div>

      <div className={`input-field col s12 ${classError(errors.numberOfTries)}`}>
        <input
          id="question-precision"
          type="number"
          className="validate"
          value={numberOfTries}
          onChange={onChangeNumberOfTries}
        />
        <label htmlFor="question-precision">Precisão</label>
        {getError(errors.numberOfTries)}
      </div>

      <div className="col l3 s6">
        <button className="waves-effect waves-light btn" onClick={onClick}>
          {actionText}
        </button>
      </div>

      <div className="col l3 s6">
        <button className="waves-effect waves-light btn red" onClick={onClose}>
          Cancelar
        </button>
      </div>
    </div>
  </React.Fragment>
);

Component.propTypes = {
  errors: PropTypes.object.isRequired,
  content: PropTypes.string,
  numberOfTries: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number,
  ]),
  onClick: PropTypes.func.isRequired,
  onClose: PropTypes.func.isRequired,
  actionText: PropTypes.string.isRequired,
  onChangeNumberOfTries: PropTypes.func.isRequired,
  onChangeContent: PropTypes.func.isRequired,
}

export default Component;
