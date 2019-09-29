import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Paper, Collapse, Button } from '@material-ui/core';
import { withStyles } from '@material-ui/styles';
import { Keyboard } from 'react-material-keyboard';
import { Close } from '@material-ui/icons';

import TextField from '../../../../materialize/form/TextField';
import CKEditor from '../../../../ckeditor';

class Form extends Component {
  constructor (props) {
    super(props);

    this.state = {
      title: '',
      content: '',
      correct_answer: '',
      answer_tex: '',
      precision: null,
      variable: '',
    }

    this.onChangeValue = this.onChangeValue.bind(this);
    this.onChangeContent = this.onChangeContent.bind(this);
  }

  onChangeValue (event) {
    let name = event.target.name;
    let value = event.target.value;

    this.setState({ [name]: value});
  }

  onChangeContent (data) {
    this.setState({ content: data});
  }

  render () {
    const { classes } = this.props;

    return (
      <Collapse timeout="auto" in={false}>
        <Paper className={classes.root}>
          <Close className={classes.close}/>
          <div className="row">
            <TextField
              id="step_title"
              name="title"
              value={this.state.title}
              label="Título"
              col="s12"
              onChange={this.onChangeValue}
            />
            <div className="col s12">
              <p>Conteúdo</p>
              <CKEditor
                content={this.state.content}
                onChange={this.onChangeContent}
              />
            </div>
            <div className="col s8">
              <p>Resposta</p>
              <Keyboard />
            </div>
            <div className="col s4">
              <TextField
                id="variable"
                name="variable"
                value={this.state.variable}
                label="Variável"
                col="s12"
                onChange={this.onChangeValue}
              />
              <Button variant="contained" color="primary">
                Adicionar váriavel
              </Button>
            </div>
            <div className="col s12 clearfix">
              <Button variant="contained" color="primary" className="right">
                CRIAR PASSO
              </Button>
            </div>
          </div>
        </Paper>
      </Collapse>
    );
  }
}

Form.propTypes = {
  classes: PropTypes.object.isRequired,
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
  }
};

export default withStyles(styles)(Form);
