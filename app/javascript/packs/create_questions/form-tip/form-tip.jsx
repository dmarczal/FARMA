import React from 'react';
import PropTypes from 'prop-types';

import Component from './component'

class FormTip extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      content: props.currentTip.content,
      numberOfTries: props.currentTip.numberOfTries,
    }

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChangeContent = this.handleChangeContent.bind(this);
    this.handleChangeNumberOfTries = this.handleChangeNumberOfTries.bind(this);
  }

  handleChangeContent(content) {
    this.setState({ content });
  }

  handleChangeNumberOfTries(event) {
    let numberOfTries = event.target.value;
    this.setState({ numberOfTries });
  }

  handleSubmit() {
    let { content, numberOfTries } = this.state;
    this.props.onSubmitTip({ content, numberOfTries });
  }

  componentDidMount() {
    Materialize.updateTextFields();
  }

  componentDidUpdate() {
    Materialize.updateTextFields();
  }

  render() {
    let { currentTip } = this.props;
    let actionText = currentTip.id ? "Atualizar dica" : "Criar dica";

    return (
      <Component
        errors={this.props.errors}
        content={this.state.content}
        numberOfTries={this.state.numberOfTries}
        onClick={this.handleSubmit}
        onClose={this.props.onClose}
        actionText={actionText}
        onChangeNumberOfTries={this.handleChangeNumberOfTries}
        onChangeContent={this.handleChangeContent}
      />
    );
  }
}

FormTip.propTypes = {
  errors: PropTypes.object.isRequired,
  onClose: PropTypes.func.isRequired,
  onSubmitTip: PropTypes.func.isRequired,
  currentTip: PropTypes.object.isRequired,
}

export default FormTip;
