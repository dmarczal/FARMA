import React from 'react';
import PropTypes from 'prop-types';
import renderHTML from 'react-render-html';

const renderPrecision = (precision) => {
  return precision ? (<span>Precisão: { precision }</span>) : '';
}

const Component = ({
  title,
  index,
  content,
  precision,
  correctAnswer,
  onOpenContent,
  onDelete,
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
          <div className="right">
            <i className="fa fa-pencil"></i>
          </div>
        </div>
        <div className="col s12">
          <i className="fa fa-chevron-down open-question" onClick={onOpenContent}></i>
        </div>
      </div>
    </div>
    <div className="collapsible-body">
      { renderHTML(content) }
      { renderPrecision(precision) }
      <br />
      <span>Resposta correta: {correctAnswer}</span>
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
}

export default Component;
