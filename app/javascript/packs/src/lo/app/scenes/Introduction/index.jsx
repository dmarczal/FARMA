import React from 'react';
import renderHTML from 'react-render-html';
import {
  Paper,
  Typography,
} from '@material-ui/core'
import styles from './styles';

export default () => {
  const classes = styles();

  return (
    <Paper className={classes.root}>
      <Typography variant="h6">
        Introdução 1
      </Typography>
      <Typography variant="h5">
        Introdução teste
      </Typography>
      {renderHTML('<p>Descrição <strong>test</strong></p>')}
    </Paper>
  );
};
