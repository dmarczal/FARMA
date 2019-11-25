import React from 'react';
import Component from './Component';

class Exercise extends React.Component {
  constructor (props) {
    super (props);

    this.state = {
      isOpenKeyboard: false,
      correct: false,
      value: null,
      stepId: null,
      variables: [],
      responses: [],
    };

    this.handleOpenKeyboard = this.handleOpenKeyboard.bind(this);
    this.handleCloseKeyboard = this.handleCloseKeyboard.bind(this);
  }

  handleOpenKeyboard (
    stepId,
    value,
    correct,
    variables,
    responses
  ) {
    this.setState({
      stepId,
      value,
      correct,
      variables,
      isOpenKeyboard: true,
      responses,
    });
  }

  handleCloseKeyboard () {
    this.setState({
      value: null,
      isOpenKeyboard: false,
      stepId: null,
      variables: [],
      responses: [],
    });
  }

  render () {
    let {
      value,
      isOpenKeyboard,
      correct,
      variables,
      responses,
      stepId,
    } = this.state;

    let { data, onCreateAnswer } = this.props;

    let currentValue = value === null ? null : {
      value, correct
    };

    return (
      <Component
        openKeyboard={this.handleOpenKeyboard}
        closeKeyboard={this.handleCloseKeyboard}
        value={currentValue}
        isOpenKeyboard={isOpenKeyboard}
        variables={variables}
        onCreateAnswer={onCreateAnswer}
        data={data}
        responses={responses}
        stepId={stepId}
      />
    )
  }
}

export default Exercise;
