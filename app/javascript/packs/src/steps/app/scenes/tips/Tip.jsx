import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux'
import TipComponent from '../../components/tips/TipComponent';
import { formTip, deleteTip } from '../../store/actions/tips';

class Step extends Component {
  constructor (props) {
    super(props);
    this.state = {
      openCollapse: false,
    };

    this.handleOpenStep = this.handleOpenStep.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
  }

  handleDelete (id) {
    let { stepId, onDelete } = this.props;

    onDelete(stepId, id);
  }

  handleOpenStep () {
    let { openCollapse } = this.state;
    this.setState({ openCollapse: !openCollapse });
  }

  render () {
    let { openCollapse } = this.state;
    let {
      id,
      content,
      number_of_tries,
      onEdit,
      number,
    } = this.props;

    let data = {
      id,
      content,
      number_of_tries,
    };

    return (
      <TipComponent
        number={number}
        data={data}
        openCollapse={openCollapse}
        onOpen={this.handleOpenStep}
        onEdit={onEdit}
        onDelete={this.handleDelete}
      />
    );
  }
}

Step.propTypes = {
  id: PropTypes.number,
  number: PropTypes.number.isRequired,
  content: PropTypes.string.isRequired,
  stepId: PropTypes.string.isRequired,
  number_of_tries: PropTypes.number.isRequired,
  onEdit: PropTypes.func.isRequired,
  onDelete: PropTypes.func.isRequired,
};

const mapDispatchToProps = dispatch => ({
  onEdit (data) {
    dispatch(formTip(data));
  },

  onDelete (stepId, id) {
    dispatch(deleteTip(stepId, id));
  },
});

export default connect(
  null,
  mapDispatchToProps
)(Step);
