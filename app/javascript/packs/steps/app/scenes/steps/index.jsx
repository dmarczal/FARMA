import React, { Fragment } from 'react';
import { Fab } from '@material-ui/core';
import { Add } from '@material-ui/icons';
import { makeStyles } from '@material-ui/core/styles';

import Step from './Step';
import Form from './Form';

const styles = makeStyles(theme => ({
  fab: {
    position: 'fixed',
    right: '10px',
    bottom: '10px',
  }
}));

export default () => {
  const classes = styles();

  return (
    <Fragment>
      <Form />
      <Step />
      <Step />
      <Fab color="primary" aria-label="add" className={classes.fab}>
        <Add />
      </Fab>
    </Fragment>
  );
}
