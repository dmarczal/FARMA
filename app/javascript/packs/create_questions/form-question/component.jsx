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
  title,
  content,
  correctAnswer,
  precision,
  onChangeTitle,
  onChangeContent,
  onChangeCorrectAnswer,
  onChangePrecision,
  onClick,
  errors
}) => (
  <div className="question-form-component z-depth-3">
    <h3 className="center-align">Nova Questão</h3>
    <div className="row form">
      <div className={`input-field col s12 ${classError(errors.title)}`}>
        <input
          id="question-title"
          type="text"
          className="validate"
          value={title}
          onChange={onChangeTitle}
        />
        <label htmlFor="question-title">Título</label>
        {getError(errors.title)}
      </div>

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

      <div className={`input-field col s12 ${classError(errors.precision)}`}>
        <input
          id="question-precision"
          type="number"
          className="validate"
          value={precision}
          onChange={onChangePrecision}
        />
        <label htmlFor="question-precision">Precisão</label>
        {getError(errors.precision)}
      </div>

      <div className={`input-field col s12 ${classError(errors.correctAnswer)}`}>
        <input
          id="question-correct-answer"
          type="text"
          className="validate"
          value={correctAnswer}
          onChange={onChangeCorrectAnswer}
        />
        <label htmlFor="question-correct-answer">Resposta</label>
        {getError(errors.correctAnswer)}
      </div>

      <div className="col s12">
        <button className="waves-effect waves-light btn" onClick={onClick}>
          Cadastrar
        </button>
      </div>
    </div>
  </div>
);

Component.propTypes = {
  title: PropTypes.string,
  content: PropTypes.string,
  correctAnswer: PropTypes.string,
  precision: PropTypes.string,
  onChangeTitle: PropTypes.func.isRequired,
  onChangeContent: PropTypes.func.isRequired,
  onChangeCorrectAnswer: PropTypes.func.isRequired,
  onChangePrecision: PropTypes.func.isRequired,
  onClick: PropTypes.func.isRequired,
  errors: PropTypes.object.isRequired,
}

export default Component;
