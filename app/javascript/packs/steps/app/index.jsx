import React, { Component } from 'react';
import PropTypes from 'prop-types';
import store from './store';
import Router from './router';
import { loadExercise } from './store/actions/index';

class App extends Component {
  constructor (props) {
    super(props);
    let { exerciseId } = this.props;
    store.dispatch(loadExercise(exerciseId));
  }

  render () {
    return <Router store={store} />;
  }
}

App.propTypes = {
  exerciseId: PropTypes.number.isRequired,
}

export default App;
