import React from 'react';
import PropTypes from 'prop-types';
import { Grid } from '@material-ui/core';
import {
  grey,
  green,
} from '@material-ui/core/colors';

const LinkSideBar = ({ steps }) => (
  <Grid container spacing={1}>
    {steps.map((correct, index) => {
      let color = green[600];

      if (correct === false) {
        color = green['A200'];
      }

      if (correct === null) {
        color = grey[500];
      }

      return (
        <Grid item xs={2} key={index}>
          <p style={{
            backgroundColor: color,
            padding: 1,
            borderRadius: 50,
            textAlign: 'center',
            margin: 0,
          }}>{index+1}</p>
        </Grid>
      )
    })}
  </Grid>
)

LinkSideBar.propTypes = {
  steps: PropTypes.array.isRequired,
}

export default LinkSideBar;
