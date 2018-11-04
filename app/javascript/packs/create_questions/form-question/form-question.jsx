import React from 'react';
import PropTypes from 'prop-types';

import Component from './component'

class FormQuestion extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      title: props.title,
      content: props.content,
      correctAnswer: props.correctAnswer,
      precision: props.precision,
    }

    this.handleChangeTitle = this.handleChangeTitle.bind(this);
    this.handleChangeContent = this.handleChangeContent.bind(this);
    this.handleChangeCorrectAnswer = this.handleChangeCorrectAnswer.bind(this);
    this.handleChangePrecision = this.handleChangePrecision.bind(this);
  }

  handleChangeTitle(event) {
    let title = event.target.value;

    this.setState({ title });
  }

  handleChangeContent(content) {
    this.setState({ content });
  }

  handleChangeCorrectAnswer(event) {
    let correctAnswer = event.target.value;

    this.setState({ correctAnswer });
  }

  handleChangePrecision(event) {
    let precision = event.target.value;

    this.setState({ precision });
  }

  render() {
    let { onClick } = this.props

    return (
      <Component
        title={this.state.title}
        content={this.state.content}
        correctAnswer={this.state.correctAnswer}
        precision={this.state.precision}
        onChangeTitle={this.handleChangeTitle}
        onChangeContent={this.handleChangeContent}
        onChangeCorrectAnswer={this.handleChangeCorrectAnswer}
        onChangePrecision={this.handleChangePrecision}
        onClick={() => onClick(this.state)}
        errors={this.props.errors}
      />
    );
  }
}

FormQuestion.propTypes = {
  onClick: PropTypes.func.isRequired,
  errors: PropTypes.object.isRequired,
}

export default FormQuestion;
