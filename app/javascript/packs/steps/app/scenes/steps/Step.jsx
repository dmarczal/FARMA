import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux'
import StepComponent from '../../components/steps/StepComponent';
import { formStep, deleteStep } from '../../store/actions/steps';

class Step extends Component {
  constructor (props) {
    super(props);
    this.state = {
      openCollapse: false,
    };

    this.handleOpenStep = this.handleOpenStep.bind(this);
  }

  handleOpenStep () {
    let { openCollapse } = this.state;
    this.setState({ openCollapse: !openCollapse });
  }

  render () {
    let { openCollapse } = this.state;
    let {
      id,
      number,
      title,
      content,
      correct_answer,
      answer_tex,
      precision,
      variables,
      onEditStep,
      deleteStep,
    } = this.props;

    let data = {
      id,
      title,
      content,
      correct_answer,
      answer_tex,
      precision,
      variables,
    };

    return (
      <StepComponent
        number={number}
        data={data}
        openCollapse={openCollapse}
        onOpen={this.handleOpenStep}
        onEditStep={onEditStep}
        deleteStep={deleteStep}
      />
    );
  }
}

Step.propTypes = {
  id: PropTypes.number,
  title: PropTypes.string.isRequired,
  content: PropTypes.string.isRequired,
  correct_answer: PropTypes.string.isRequired,
  answer_tex: PropTypes.string.isRequired,
  precision: PropTypes.number,
  variables: PropTypes.array.isRequired,
  onEditStep: PropTypes.func.isRequired,
  deleteStep: PropTypes.func.isRequired,
};

const mapDispatchToProps = dispatch => ({
  onEditStep (data) {
    dispatch(formStep(data));
  },

  deleteStep (id) {
    dispatch(deleteStep(id));
  },
});

export default connect(
  null,
  mapDispatchToProps
)(Step);
