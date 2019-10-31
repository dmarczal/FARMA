import React from "react";
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

export default ({
  openKeyboard,
  value,
  isOpenKeyboard,
  closeKeyboard,
  variables,
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
            Exercício 1
          </Typography>
          <Typography variant="h5">
            Exercício teste
          </Typography>
          {renderHTML('<p>Descrição <strong>test</strong></p>')}
        </Paper>
      </Grid>

      <Grid item xs={8} className={classes.marginGrid}>
        <Paper className={classes.step}>
          <Typography variant="h6">
            Passo 1
          </Typography>
          <Typography variant="h5">
          Passo teste
          </Typography>
          {renderHTML('<p>Descrição <strong>test</strong></p>')}
        </Paper>
        <Fab
            color="primary"
            size="small"
            className={classes.btnResponses}
        >
          5
        </Fab>
        <Paper
          className={classes.responsePaper}
          onClick={() => openKeyboard('2*x', true, ['x'])}
        >
          <div
            className={classes.response}
            style={{borderColor: '#228416'}}
          >
            <MathJax.Provider>
              <MathJax.Node formula={'2*x'} />
            </MathJax.Provider>
            <Typography
              variant="inherit"
              component="span"
              className={classes.status}
              style={{color: "#228416"}}
            >
              Correto
            </Typography>
          </div>
        </Paper>
      </Grid>

      <Grid item xs={4} className={classes.marginGrid}></Grid>

      <Grid item xs={8} className={classes.marginGrid}>
        <Paper className={classes.step}>
          <Typography variant="h6">
            Passo 1
          </Typography>
          <Typography variant="h5">
          Passo teste
          </Typography>
          {renderHTML('<p>Descrição <strong>test</strong></p>')}
        </Paper>
        <Paper
          className={classes.responsePaper}
          onClick={() => openKeyboard('2*x', false, ['x'])}
        >
          <div
            className={classes.response}
            style={{borderColor: "#ec211d"}}
          >
            <MathJax.Provider>
              <MathJax.Node formula={'2*x'} />
            </MathJax.Provider>
            <Typography
              variant="inherit"
              component="span"
              className={classes.status}
              style={{color: "#ec211d"}}
            >
              Incorreto
            </Typography>
          </div>
        </Paper>
      </Grid>

      <Grid item xs={4} className={classes.marginGrid}></Grid>

      <Grid item xs={8} className={classes.marginGrid}>
        <Paper className={classes.step}>
          <Typography variant="h6">
            Passo 1
          </Typography>
          <Typography variant="h5">
          Passo teste
          </Typography>
          {renderHTML('<p>Descrição <strong>test</strong></p>')}
        </Paper>
        <Paper
          className={classes.responsePaper}
          onClick={() => openKeyboard(null)}
        >
          <div className={classes.responseEmpty}>
            <Typography variant="h6">
              Clique aqui para responder
            </Typography>
          </div>
        </Paper>
      </Grid>

      <Grid item xs={4} className={classes.marginGrid}></Grid>
    </Grid>
  );
};
