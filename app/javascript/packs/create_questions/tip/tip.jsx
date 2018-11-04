import React from 'react';
import PropTypes from 'prop-types';
import renderHTML from 'react-render-html';

class Tip extends React.Component {
  render() {
    let {
      content,
      number_of_tries,
      onRemove,
      onEdit,
      index,
    } = this.props;

    return (
      <li className="collection-item clearfix">
        <div className="row">
          <div className="col s6">
            {renderHTML(content)}
            Tentativas: {number_of_tries}
          </div>
          <div className="col s6">
            <div className="right">
              <i className="fa fa-trash" onClick={() => onRemove(index)}></i>
            </div>
            <div className="right">
              <i className="fa fa-pencil" onClick={() => onEdit(index)}></i>
            </div>
          </div>
        </div>
      </li>
    );
  }
}

Tip.propTypes = {
  index: PropTypes.number.isRequired,
  content: PropTypes.string.isRequired,
  number_of_tries: PropTypes.number.isRequired,
  onRemove: PropTypes.func.isRequired,
  onEdit: PropTypes.func.isRequired,
}

export default Tip;
