import React from 'react';
import renderHTML from 'react-render-html';
import {
  Paper,
  Typography,
} from '@material-ui/core'
import styles from './styles';

export default ({
  data
}) => {
  const classes = styles();

  return (
    <Paper className={classes.root}>
      <Typography variant="h6">
        Introdução {data.position}
      </Typography>
      <Typography variant="h5">
        {data.title}
      </Typography>
      {renderHTML(data.content)}
    </Paper>
  );
};
