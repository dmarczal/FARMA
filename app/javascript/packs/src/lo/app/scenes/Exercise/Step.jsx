import React, {
  Component,
  Fragment,
} from 'react';

import {
  Close,
  ArrowLeft,
  ArrowRight,
  EmojiObjects,
} from '@material-ui/icons';

import {
  Fab,
  Collapse,
  Divider,
  Table,
  TableHead,
  TableRow,
  TableCell,
  TableBody,
  Typography,
  Grid,
  Paper,
} from '@material-ui/core';

import MathJax from 'react-mathjax';
import renderHTML from 'react-render-html';

class Step extends Component {
  constructor (props) {
    super (props);

    let { step } = this.props;

    this.state = {
      showTable: false,
      currentTip: step.tips.length,
      newTip: true,
      showTip: false,
    };

    this.setTable = this.setTable.bind(this);
    this.setTipLeft = this.setTipLeft.bind(this);
    this.setTipRight = this.setTipRight.bind(this);
    this.setToggleTip = this.setToggleTip.bind(this);
  }

  setToggleTip () {
    let { showTip } = this.state;

    this.setState({
      showTip: !showTip,
      newTip: false,
    });
  }

  setTipLeft () {
    let { currentTip } = this.state;

    if (currentTip === 1) return;

    this.setState({currentTip: currentTip - 1});
  }

  setTipRight () {
    let { step } = this.props;
    let { currentTip } = this.state;

    if (step.tips.length === currentTip) return;

    this.setState({currentTip: currentTip + 1});
  }

  setTable () {
    let { showTable } = this.state;
    this.setState({ showTable: !showTable });
  }

  getTable(responses, showTable, classes) {
    let response = Object.assign({}, responses[0]);
    delete response.id;
    delete response.tex;
    let header = Object.keys(response);

    return (
      <Collapse
        className={classes.table}
        in={showTable}
        timeout="auto"
        unmountOnExit
      >
        <Divider />
        <Table size="small">
          <TableHead>
            <TableRow>
              <TableCell align="center">Resposta</TableCell>
              {header.map((value, index) => (
                <TableCell
                  key={value + index}
                  align="center"
                >
                  {value}
                </TableCell>
              ))}
            </TableRow>
          </TableHead>
          <TableBody>
            {responses.map((response) => (
              <TableRow key={response.id}>
                <TableCell align="center">
                  <MathJax.Node formula={response.tex} />
                </TableCell>
                {header.map((value, index) => (
                  <TableCell
                    key={value + index}
                    align="center"
                  >
                    {response[value]}
                  </TableCell>
                ))}
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </Collapse>
    )
  }

  render() {
    let {
      step,
      openKeyboard,
      classes
    } = this.props;

    let {
      showTable,
      currentTip,
      showTip,
      newTip,
    } = this.state;

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
          style={{ borderColor: value.correct ? '#228416' : '#ec211d' }}
        >
          <MathJax.Node formula={value.value} />
          <Typography
            variant="inherit"
            component="span"
            className={classes.status}
            style={{ color: value.correct ? '#228416' : '#ec211d' }}
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
        onClick={this.setTable}
      >
        {showTable ? <Close /> : step.responses.length}
      </Fab> : '';

    let fabLeft = currentTip === 1 ? '' : (
      <Fab
        color="primary"
        size="small"
        className={classes.tipLeft}
        onClick={this.setTipLeft}
      >
        <ArrowLeft />
      </Fab>
    );

    let fabRight = step.tips.length === currentTip ? '' : (
      <Fab
        color="primary"
        size="small"
        className={classes.tipRight}
        onClick={this.setTipRight}
      >
        <ArrowRight />
      </Fab>
    );

    let colorTip = newTip && step.newTip ? 'yellow' : 'grey';

    let tipShowBtn = step.tips.length > 0 ? (
      <EmojiObjects
        className={classes.tipShow}
        style={{color: colorTip}}
        onClick={this.setToggleTip}
      />
    ) : '';

    let tip = step.tips.length > 0 && showTip ? (
      <Fragment>
        <Paper className={classes.tips}>
          <Typography variant="h6">
            Dica {currentTip}
          </Typography>
          {renderHTML(step.tips[currentTip-1].content)}
          <Typography variant="body1">
            Tentativas: {step.tips[currentTip-1].number_of_tries}
          </Typography>
        </Paper>
        {fabLeft}
        {fabRight}
      </Fragment>
    ) : '';

    return (
      <MathJax.Provider>
        <Grid item xs={8} className={classes.marginGrid}>
          <Paper className={classes.step}>
            <Typography variant="h6">
              Passo {step.position}
            </Typography>
            <Typography variant="h5">
              {step.title}
            </Typography>
            {renderHTML(step.content)}
            {tipShowBtn}
          </Paper>
          {responsesBtn}
          {this.getTable(step.responses, showTable, classes)}
          <Paper
            className={classes.responsePaper}
            onClick={() => openKeyboard(
              value.value,
              value.correct,
              step.variables,
              step.responses
            )}
          >
            {valueComponet}
          </Paper>
        </Grid>

        <Grid
          item
          xs={4}
          className={classes.marginGrid}
        >
          {tip}
        </Grid>
      </MathJax.Provider>
    );
  }
}

export default Step;
