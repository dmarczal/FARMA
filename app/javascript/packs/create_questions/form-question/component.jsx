import React from 'react';
import PropTypes from 'prop-types';
import CKEditor from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import { Keyboard } from 'react-material-keyboard';

import { format } from '../../libs/format-answer';

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
  errors,
  actionText,
  onClose,
  compRef,
}) => (
  <div className="question-form-component z-depth-3" ref={compRef}>
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
        <span className="label">Conteúdo</span>
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

      <div className={`input-field col s6 ${classError(errors.correctAnswer)}`}>
        <span className="label">Resposta corréta</span>
        <Keyboard
          onSubmit={onChangeCorrectAnswer}
          screenText="Adicionar Resposta"
          value={format(correctAnswer)}
        />
        {getError(errors.correctAnswer)}
      </div>

      <div className="divider col s12"></div>

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
  </div>
);

Component.propTypes = {
  title: PropTypes.string,
  content: PropTypes.string,
  correctAnswer: PropTypes.string,
  precision: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number,
  ]),
  onChangeTitle: PropTypes.func.isRequired,
  onChangeContent: PropTypes.func.isRequired,
  onChangeCorrectAnswer: PropTypes.func.isRequired,
  onChangePrecision: PropTypes.func.isRequired,
  onClick: PropTypes.func.isRequired,
  onClose: PropTypes.func.isRequired,
  errors: PropTypes.object.isRequired,
}

export default Component;
