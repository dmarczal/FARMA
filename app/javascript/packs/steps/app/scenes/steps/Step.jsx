import React, { Component } from 'react';
import StepComponent from '../../components/steps/StepComponent';

export default class Step extends Component {
  constructor (props) {
    super(props);
    this.state = {
      openCollapse: false
    };

    this.handleOpenStep = this.handleOpenStep.bind(this);
  }

  handleOpenStep () {
    let { openCollapse } = this.state;
    this.setState({ openCollapse: !openCollapse });
  }

  render () {
    let { openCollapse } = this.state;

    return (
      <StepComponent
        number={1}
        title="Teste"
        openCollapse={openCollapse}
        onOpen={this.handleOpenStep}
      />
    );
  }
}
