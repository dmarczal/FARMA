import React from 'react';
import PropTypes from 'prop-types';

import Tip from '../tip';

class Tips extends React.Component {
  render() {
    let { tips, onEdit, onRemove } = this.props;

    return (
      <ul className="collection with-header tips">
        <li className="collection-header"><h3>Dicas</h3></li>
        {
          tips.length == 0 ?
            <li className="collection-item">Nenhuma dica para esse passo</li>
            :
            tips.map((tip, index) =>
              <Tip
                key={tip.id}
                index={index}
                onEdit={onEdit}
                onRemove={onRemove}
                {...tip}
              />
            )
        }
      </ul>
    )
  }
}

Tips.propTypes = {
  tips: PropTypes.array.isRequired,
  onEdit: PropTypes.func.isRequired,
  onRemove: PropTypes.func.isRequired,
}

export default Tips;
