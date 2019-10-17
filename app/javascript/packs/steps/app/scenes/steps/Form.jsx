import React, { Component, Fragment } from 'react';
import { connect } from 'react-redux'
import PropTypes from 'prop-types';
import { Paper, Button } from '@material-ui/core';
import { withStyles } from '@material-ui/styles';
import {
  Keyboard,
  mapEvents,
  mapKeys,
  defaultKeyboard,
  Value,
} from 'react-material-keyboard';
import { Close } from '@material-ui/icons';

import TextField from '../../../../materialize/form/TextField';
import CKEditor from '../../../../ckeditor';


function getKeyboard (variables = []) {
  let line = [];
  let keyboard = [...defaultKeyboard];

  if (variables.length === 0) {
    return {
      variables,
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
    variables,
    keyboard,
    mapKeys,
    mapEvents,
  };
}

class Form extends Component {
  constructor (props) {
    super(props);

    this.state = {
      ...props.step,
      ...getKeyboard(props.step.variables),
      variable: '',
      hasPrecision: !isNaN(props.step.correct_answer),
    };

    this.onChangeValue = this.onChangeValue.bind(this);
    this.onChangeContent = this.onChangeContent.bind(this);
    this.addVariable = this.addVariable.bind(this);
    this.removeVariable = this.removeVariable.bind(this);
    this.handleOnChangeResponse = this.handleOnChangeResponse.bind(this);
    this.handleOnSubmit = this.handleOnSubmit.bind(this);
  }

  onChangeValue (event) {
    let name = event.target.name;
    let value = event.target.value;

    if (name === 'variable') {
      var letters = /^[a-z]+$/;
      value = value[value.length -1].toLowerCase();

      if(!value.match(letters)) {
        return;
      }

      return this.setState({ [name]: value});
    }

    this.setState({ [name]: value});
  }

  onChangeContent (data) {
    this.setState({ content: data });
  }

  handleOnChangeResponse ({ value, value_tex }) {
    let hasPrecision = !isNaN(value);
    let precision = hasPrecision ? precision : null;

    this.setState({
      correct_answer: value,
      answer_tex: value_tex,
      hasPrecision,
      precision
    });
  }

  addVariable () {
    let {
      variables,
      variable,
    } = this.state;

    if (variable && !variables.includes(variable)) {
      variables.push(variable);

      this.setKeyboard(getKeyboard(variables));
    }
  }

  removeVariable () {
    let {
      variables,
      variable,
    } = this.state;

    if (variable && variables.includes(variable)) {
      let newVariables = [];

      variables.forEach(currentVariable => {
        if (currentVariable !== variable) {
          newVariables.push(currentVariable);
        }
      });

      this.setKeyboard(getKeyboard(newVariables));
    }
  }

  setKeyboard ({
    variables,
    keyboard,
    mapKeys,
    mapEvents,
  }) {
    this.setState({
      variables,
      keyboard,
      mapKeys,
      mapEvents,
    });
  }

  handleOnSubmit () {
    let {
      id,
      title,
      content,
      correct_answer,
      answer_tex,
      precision,
      variables,
    } = this.state;

    this.props.onSubmit({
      id,
      title,
      content,
      correct_answer,
      answer_tex,
      precision,
      variables,
    });
  }

  componentDidUpdate () {
    M.updateTextFields();
  }

  componentDidMount () {
    M.updateTextFields();
  }

  render () {
    let {
      classes,
      close,
      errors,
    } = this.props;

    let {
      id,
      title,
      content,
      variable,
      keyboard,
      mapKeys,
      mapEvents,
      correct_answer,
      hasPrecision,
      precision,
    } = this.state;

    let currentResponse = correct_answer ? {
      value: correct_answer
    } : null;

    let errorContent = errors.content ?
      <span className="help-block">{errors.content[0]}</span> : '';

    let errorAnswer = errors.correct_answer ?
      (
        <Fragment>
          <br/>
          <span className="help-block">{errors.correct_answer[0]}</span>
        </Fragment>
      ) : '';

    let inputPrecision =  hasPrecision ? (
      <TextField
        id="step_precision"
        name="precision"
        value={precision || ''}
        label="Precisão"
        col="s12"
        onChange={this.onChangeValue}
        errors={errors.precision}
      />
    ) : '';

    return (
      <form noValidate className="simple_form">
        <Paper className={classes.root}>
          <Close
            className={classes.close}
            onClick={() => close()}
          />
          <div className="row">
            <TextField
              id="step_title"
              name="title"
              value={title}
              label="Título"
              col="s12"
              onChange={this.onChangeValue}
              errors={errors.title}
            />
            <div className={'col s12 ' + (errorContent ? 'has-error' : '')}>
              <p>Conteúdo</p>
              <CKEditor
                content={content}
                onChange={this.onChangeContent}
              />
              {errorContent}
            </div>
            <div className={'col s7 ' + (errorAnswer ? 'has-error' : '')}>
              <p>Resposta</p>
              {errorAnswer}
              <Keyboard
                keyboard={keyboard}
                mapEvents={mapEvents}
                mapKeys={mapKeys}
                current={currentResponse}
                onChange={this.handleOnChangeResponse}
              />
            </div>
            <div className="col s5">
              {inputPrecision}

              <TextField
                id="variable"
                name="variable"
                value={variable}
                label="Variável"
                col="s12"
                onChange={this.onChangeValue}
              />
              <Button
                className="left"
                variant="contained"
                color="primary"
                onClick={this.addVariable}
              >
                Adicionar váriavel
              </Button>

              <Button
                className="right"
                variant="contained"
                color="secondary"
                onClick={this.removeVariable}
              >
                Remover váriavel
              </Button>
            </div>
            <div className="col s12 clearfix">
              <Button
                variant="contained"
                color="primary"
                className="right"
                onClick={this.handleOnSubmit}
              >
                {id ? 'EDITAR':'CRIAR'} PASSO
              </Button>
            </div>
          </div>
        </Paper>
      </form>
    );
  }
}

Form.propTypes = {
  classes: PropTypes.object.isRequired,
  close: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired,
  errors: PropTypes.object.isRequired,
  step: PropTypes.exact({
    id: PropTypes.number,
    title: PropTypes.string.isRequired,
    content: PropTypes.string.isRequired,
    correct_answer: PropTypes.string.isRequired,
    answer_tex: PropTypes.string.isRequired,
    precision: PropTypes.number,
    variables: PropTypes.array.isRequired,
  }).isRequired,
};

const styles = {
  root: {
    position: 'relative',
    margin: '10px 0',
    padding: '10px',
  },
  close: {
    position: 'absolute',
    right: '5px',
    top: '5px',
    cursor: 'pointer',
  }
};

const mapStateToProps = ({ requestLoad }) => {
  return {
    errors: requestLoad.errors,
  };
}

export default connect(mapStateToProps)(withStyles(styles)(Form));
