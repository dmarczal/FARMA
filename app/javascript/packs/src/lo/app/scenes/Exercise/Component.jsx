import React from "react";
import renderHTML from 'react-render-html';
import Step from './Step';

import { Close } from '@material-ui/icons';

import {
  Keyboard,
  mapEvents,
  mapKeys,
  defaultKeyboard,
  Value,
} from 'react-material-keyboard';

import {
  Paper,
  Typography,
  Grid,
} from '@material-ui/core'

import styles from './styles';

const getKeyboard = (variables = []) => {
  let line = [];
  let keyboard = [...defaultKeyboard];

  if (variables.length === 0) {
    return {
      keyboard,
      mapKeys,
      mapEvents,
    };
  }

  variables.forEach(variable => {
    if (line.length === 4) {
      keyboard.push(line);
      line = [];
    }

    line.push(variable);
    mapKeys.set(variable, mapKeys.getComponent(variable, variable));
    mapEvents.set(variable, (value) => (new Value(variable, value)));
  });

  if (line.length > 0) {
    keyboard.push(line);
  }

  return {
    keyboard,
    mapKeys,
    mapEvents,
  };
}

export default ({
  openKeyboard,
  value,
  isOpenKeyboard,
  closeKeyboard,
  variables,
  data,
  responses,
  stepId,
  onCreateAnswer,
}) => {
  const classes = styles();
  let keyboardComp = '';
  let {
    keyboard,
    mapKeys,
    mapEvents,
  } = getKeyboard(variables);

  if (isOpenKeyboard) {
    keyboardComp = (
      <Grid
        container
        direction="row"
        justify="center"
        alignItems="center"
        className={classes.keyboardBox}
      >
        <Close
          className={classes.keyboardClose}
          onClick={closeKeyboard}
        />

        <Grid item xs={6}>
          <Keyboard
            keyboard={keyboard}
            mapEvents={mapEvents}
            mapKeys={mapKeys}
            responses={responses}
            current={value}
            onSubmit={({ value, value_tex }) =>
              onCreateAnswer(data.id, stepId, value, value_tex)
            }
          />
        </Grid>
      </Grid>
    );
  }

  return (
    <Grid container justify="center" spacing={1}>
      {keyboardComp}

      <Grid item xs={12} className={classes.marginGrid}>
        <Paper className={classes.rootPaper}>
          <Typography variant="h6">
            Exercício {data.position}
          </Typography>
          <Typography variant="h5">
            {data.title}
          </Typography>
          {renderHTML(data.content)}
        </Paper>
      </Grid>

      {data.steps.map((step) => (
        <Step
          key={step.position + 'steps'}
          step={step}
          openKeyboard={openKeyboard}
          classes={classes}
        />
      ))}
    </Grid>
  );
};
