import React from 'react';
import Component from './Component';

class Exercise extends React.Component {
  constructor (props) {
    super (props);

    this.state = {
      isOpenKeyboard: false,
      correct: false,
      value: null,
      variables: [],
      responses: [],
    };

    this.handleOpenKeyboard = this.handleOpenKeyboard.bind(this);
    this.handleCloseKeyboard = this.handleCloseKeyboard.bind(this);
  }

  handleOpenKeyboard (
    value,
    correct,
    variables,
    responses
  ) {
    this.setState({
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
    } = this.state;

    let { data } = this.props;

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
        data={data}
        responses={responses}
      />
    )
  }
}

export default Exercise;
