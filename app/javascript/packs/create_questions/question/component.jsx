import React from 'react';
import PropTypes from 'prop-types';
import renderHTML from 'react-render-html';
import MathJax from 'react-mathjax';

import Tips from '../tips';
import FormTip from '../form-tip';
import TestQuestion from '../test-question';

const renderPrecision = (precision) => {
  return precision ? (<span>Precisão: { precision }</span>) : '';
}

const renderTipForm = (
  formTipOpen,
  errors,
  onClose,
  onSubmitTip,
  currentTip
) => {
  return formTipOpen ?
    (<FormTip
      errors={errors}
      onClose={onClose}
      onSubmitTip={onSubmitTip}
      currentTip={currentTip}
    />) : "";
}

const Component = ({
  title,
  index,
  content,
  precision,
  correctAnswer,
  onOpenContent,
  onDelete,
  onEdit,
  openForm,
  tips,
  formTipOpen,
  onAddTip,
  errors,
  onClose,
  onSubmitTip,
  onRemoveTip,
  onEditTip,
  currentTip,
  exerciseId,
  questionId,
}) => (
  <li>
    <div className="collapsible-header">
      <div className="row">
        <div className="col s6">
          <h3>{ index } Passo</h3>
          { title }
        </div>
        <div className="col s6">
          <div className="right">
            <i className="fa fa-trash" onClick={onDelete}></i>
          </div>
          {
            !openForm ?
              <div className="right">
                <i className="fa fa-pencil" onClick={onEdit}></i>
              </div>
              :
              ''
          }
        </div>
        <div className="col s12">
          <i className="fa fa-chevron-down open-question" onClick={onOpenContent}></i>
        </div>
      </div>
    </div>
    <div className="collapsible-body clearfix">
      <button className="waves-effect waves-light btn right" onClick={onAddTip}>Adicionar dica</button>
      { renderHTML(content) }
      { renderPrecision(precision) }
      <br />
      <span>Resposta correta</span>
      <MathJax.Provider>
        <MathJax.Node formula={correctAnswer}/>
      </MathJax.Provider>
      <TestQuestion
        exerciseId={exerciseId}
        questionId={questionId}
      />
      <Tips
        tips={tips}
        onRemove={onRemoveTip}
        onEdit={onEditTip}
      />
      {renderTipForm(
        formTipOpen,
        errors,
        onClose,
        onSubmitTip,
        currentTip
      )}
    </div>
  </li>
);

Component.propTypes = {
  index: PropTypes.number.isRequired,
  id: PropTypes.number.isRequired,
  title: PropTypes.string.isRequired,
  content: PropTypes.string.isRequired,
  correctAnswer: PropTypes.string.isRequired,
  precision: PropTypes.number.isRequired,
  onOpenContent: PropTypes.func.isRequired,
  onEdit: PropTypes.func.isRequired,
  onDelete: PropTypes.func.isRequired,
  openForm: PropTypes.bool.isRequired,
  tips: PropTypes.array.isRequired,
  onAddTip: PropTypes.func.isRequired,
  formTipOpen: PropTypes.bool.isRequired,
  errors: PropTypes.object.isRequired,
  onClose: PropTypes.func.isRequired,
  onSubmitTip:PropTypes.func.isRequired,
  onRemoveTip: PropTypes.func.isRequired,
  onEditTip: PropTypes.func.isRequired,
  currentTip: PropTypes.object.isRequired,
}

export default Component;
