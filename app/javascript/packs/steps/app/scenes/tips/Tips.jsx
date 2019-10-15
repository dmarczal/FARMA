import React, { Component, Fragment } from 'react';
import PropTypes from 'prop-types';
import { Fab, Button } from '@material-ui/core';
import { Add, Reply } from '@material-ui/icons';
import { withStyles } from '@material-ui/core/styles';
import { PulseLoader } from 'react-spinners'
import { Link } from 'react-router-dom';

import Form from './Form';
import Tip from './Tip';

const loaderOverride = `
  display: block;
  margin: 0 auto;
  text-align: center;
`;

class Tips extends Component {
  constructor (props) {
    super (props);
    let { params: { stepId } } = this.props.match;
    this.props.load(stepId);
  }

  renderComponet () {
    let {
      isLoad,
      newTip,
      classes,
      tips,
      step,
    } = this.props;

    let { params: { stepId } } = this.props.match;

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

    return (
      <Fragment>
        <div className="divider"></div>
        <Button
          component={Link}
          to={`/`}
          color="primary"
          variant="contained"
          className={classes.back}
        >
          <Reply /> Voltar
        </Button>
        <h2 className="center">Dicas do Passo {step.title}</h2>
        <div className="divider"></div>
        {this.getForm()}
        {tips.map((tip, index) =>
          <Tip
            key={tip.id}
            number={index + 1}
            stepId={stepId}
            {...tip}
          />
        )}
        <Fab
          color="primary"
          aria-label="add"
          className={classes.fab}
          onClick={newTip}
        >
          <Add />
        </Fab>
      </Fragment>
    );
  }

  getForm () {
    let {
      tip,
      onSubmit,
      closeTip,
      openForm,
    } = this.props;

    let { params: { stepId } } = this.props.match;

    if (!openForm) return '';

    return (
      <Form
        close={closeTip}
        onSubmit={(tip) => onSubmit(stepId, tip)}
        tip={tip}
      />
    );
  }

  render () {
    return this.renderComponet();
  }
}

Tips.propTypes = {
  load: PropTypes.func.isRequired,
  newTip: PropTypes.func.isRequired,
  closeTip: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired,
  classes: PropTypes.object.isRequired,
  tips: PropTypes.array.isRequired,
  tip: PropTypes.object.isRequired,
  openForm: PropTypes.bool.isRequired,
  isLoad: PropTypes.bool.isRequired,
  step: PropTypes.object.isRequired,
};

const styles = {
  fab: {
    position: 'fixed',
    right: '10px',
    bottom: '10px',
  },
  back: {
    float: 'left',
  },
};

export default withStyles(styles)(Tips);
