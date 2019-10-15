import React, { Fragment, Component } from 'react';
import PropTypes from 'prop-types';
import { Fab } from '@material-ui/core';
import { Add } from '@material-ui/icons';
import { withStyles } from '@material-ui/core/styles';
import { PulseLoader } from 'react-spinners'

import Step from './Step';
import Form from './Form';

const styles = {
  fab: {
    position: 'fixed',
    right: '10px',
    bottom: '10px',
  }
};

const loaderOverride = `
  display: block;
  margin: 0 auto;
  text-align: center;
`;

class Steps extends Component {
  constructor (props) {
    super (props);
    this.props.load();
  }

  renderComponet () {
    let {
      classes,
      steps,
      isLoad,
      openForm,
      step,
      newStep,
      closeStep,
      onSubmit,
    } = this.props;


    if (isLoad) {
      return (
        <PulseLoader
          css={loaderOverride}
          sizeUnit={"px"}
          size={15}
          color={'#357a38'}
          loading={true}
        />
      );
    }

    let form = openForm ? (
      <Form
          step={step}
          close={closeStep}
          onSubmit={onSubmit}
        />
    ) : '';

    return (
      <Fragment>
        <div className="divider"></div>
          <h2 className="center">Passos</h2>
        <div className="divider"></div>
        {form}
        {steps.map((step, index) => (
          <Step key={step.id} number={index + 1} {...step} />
        ))}
        <Fab
          color="primary"
          aria-label="add"
          className={classes.fab}
          onClick={newStep}
        >
          <Add />
        </Fab>
      </Fragment>
    )
  }

  render () {
    return this.renderComponet();
  }
}

Steps.propTypes = {
  classes: PropTypes.object.isRequired,
  steps: PropTypes.arrayOf(PropTypes.exact({
    id: PropTypes.number.isRequired,
    title: PropTypes.string.isRequired,
    content: PropTypes.string.isRequired,
    correct_answer: PropTypes.string.isRequired,
    answer_tex: PropTypes.string.isRequired,
    precision: PropTypes.number,
    variables: PropTypes.array.isRequired,
  })).isRequired,
  load: PropTypes.func.isRequired,
  isLoad: PropTypes.bool.isRequired,
  step: PropTypes.exact({
    id: PropTypes.number,
    title: PropTypes.string.isRequired,
    content: PropTypes.string.isRequired,
    correct_answer: PropTypes.string.isRequired,
    answer_tex: PropTypes.string.isRequired,
    precision: PropTypes.number,
    variables: PropTypes.array.isRequired,
  }).isRequired,
  openForm: PropTypes.bool.isRequired,
  newStep: PropTypes.func.isRequired,
  closeStep: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired,
};

export default withStyles(styles)(Steps);
