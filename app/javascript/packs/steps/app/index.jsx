import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { ThemeProvider } from '@material-ui/styles';
import { createMuiTheme } from '@material-ui/core/styles';
import { green } from '@material-ui/core/colors';
import { Provider } from 'react-redux'

import Steps from './scenes/steps';
import store from './store';
import { loadExercise } from './store/actions/index';

const theme = createMuiTheme({
  palette: {
    primary: { main: green[500] }
  },
});

class App extends Component {
  constructor (props) {
    super(props);
    let { exerciseId } = this.props;
    store.dispatch(loadExercise(exerciseId));
  }

  render () {
    return (
      <Provider store={store}>
        <ThemeProvider theme={theme}>
          <Steps />
        </ThemeProvider>
      </Provider>
    )
  }
}

App.propTypes = {
  exerciseId: PropTypes.number.isRequired,
}

export default App;
