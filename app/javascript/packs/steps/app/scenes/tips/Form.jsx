import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux'
import { Paper, Button } from '@material-ui/core';
import { withStyles } from '@material-ui/styles';
import { Close } from '@material-ui/icons';
import TextField from '../../../../materialize/form/TextField';
import CKEditor from '../../../../ckeditor';

class Form extends Component {
  constructor (props) {
    super(props);

    this.state = {
      ...this.props.tip,
    };

    this.handleChangeValue = this.handleChangeValue.bind(this);
    this.handleChangeContent = this.handleChangeContent.bind(this);
    this.handleOnSubmit = this.handleOnSubmit.bind(this);
  }

  handleChangeValue (event) {
    let name = event.target.name;
    let value = event.target.value;
    this.setState({ [name]: value});
  }

  handleChangeContent (data) {
    this.setState({ content: data });
  }

  handleOnSubmit () {
    let {
      id,
      content,
      number_of_tries,
    } = this.state;

    this.props.onSubmit({
      id,
      content,
      number_of_tries,
    });
  }

  componentDidUpdate () {
    Materialize.updateTextFields()
  }

  componentDidMount () {
    Materialize.updateTextFields()
  }

  render () {
    let {
      classes,
      close,
      errors,
    } = this.props;

    let {
      id,
      content,
      number_of_tries,
    } = this.state;

    let errorContent = errors.content ?
      <span className="help-block">{errors.content[0]}</span> : '';

    return (
      <form noValidate className="simple_form">
        <Paper className={classes.root}>
          <h2 className="center">{id ? 'Editar':'Nova'} Dica</h2>
          <Close
            className={classes.close}
            onClick={close}
          />
          <div className="row">
            <div className={'col s12 ' + (errorContent ? 'has-error' : '')}>
              <p>Conteúdo</p>
              <CKEditor
                content={content}
                onChange={this.handleChangeContent}
              />
              {errorContent}
            </div>
            <TextField
              id="tip_number_of_tries"
              name="number_of_tries"
              value={number_of_tries}
              label="Número de tentativas"
              col="s12 m6"
              onChange={this.handleChangeValue}
              errors={errors.number_of_tries}
            />
            <div className="col s12 clearfix">
              <Button
                variant="contained"
                color="primary"
                className="right"
                onClick={this.handleOnSubmit}
              >
                {id ? 'EDITAR':'CRIAR'} DICA
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
  tip: PropTypes.object.isRequired,
}

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
