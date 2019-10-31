import React, { Fragment } from "react";
import renderHTML from 'react-render-html';
import MathJax from 'react-mathjax';
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
  Fab,
} from '@material-ui/core'
import styles from './styles';

function getKeyboard (variables = []) {
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

function getStepComponent(step, openKeyboard, classes) {
  let value = step.current === null ? {
    value: null,
    correct: false,
  } : {
    value: step.current.value,
    correct: step.current.correct,
  };

  let valueComponet = step.current === null ? (
    <div
      className={classes.responseEmpty}
    >
      <Typography>
        Clique aqui para responser
      </Typography>
    </div>
  ) : (
    <div
      className={classes.response}
      style={{borderColor: value.correct ? '#228416' : '#ec211d'}}
    >
      <MathJax.Provider>
        <MathJax.Node formula={value.value} />
      </MathJax.Provider>
      <Typography
        variant="inherit"
        component="span"
        className={classes.status}
        style={{color: value.correct ? '#228416' : '#ec211d'}}
      >
        {value.correct ? 'Correto' : 'Incorreto'}
      </Typography>
    </div>
  );

  let responsesBtn = step.responses.length > 0 ?
    <Fab
      color="primary"
      size="small"
      className={classes.btnResponses}
    >
      {step.responses.length}
    </Fab> : '';

  return (
    <Fragment key={'step' + step.position}>
      <Grid item xs={8} className={classes.marginGrid}>
        <Paper className={classes.step}>
          <Typography variant="h6">
            Passo {step.position}
          </Typography>
          <Typography variant="h5">
            {step.title}
          </Typography>
          {renderHTML(step.content)}
        </Paper>
        {responsesBtn}
        <Paper
          className={classes.responsePaper}
          onClick={() => openKeyboard(value.value, value.correct, step.variables)}
        >
          {valueComponet}
        </Paper>
      </Grid>

      <Grid item xs={4} className={classes.marginGrid}></Grid>
    </Fragment>
  )
}

export default ({
  openKeyboard,
  value,
  isOpenKeyboard,
  closeKeyboard,
  variables,
  data,
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
            current={value}
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

      {data.steps.map((step) => getStepComponent(step, openKeyboard, classes))}
    </Grid>
  );
};
