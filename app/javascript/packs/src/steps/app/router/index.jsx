import React from 'react';
import PropTypes from 'prop-types';
import { Provider } from 'react-redux';
import { ThemeProvider } from '@material-ui/styles';
import { createMuiTheme } from '@material-ui/core/styles';
import { green } from '@material-ui/core/colors';
import {
  HashRouter,
  Route,
  Switch
} from 'react-router-dom';
import Steps from '../scenes/steps';
import Tips from '../scenes/tips';

const theme = createMuiTheme({
  palette: {
    primary: { main: green[500] }
  },
});

const Router = ({ store }) => (
  <Provider store={store}>
    <ThemeProvider theme={theme}>
      <HashRouter basename="/steps">
        <Switch>
          <Route exact path="/" component={Steps} />
          <Route path="/:stepId/tips" component={Tips} />
        </Switch>
      </HashRouter>
    </ThemeProvider>
  </Provider>
);

Router.propTypes = {
  store: PropTypes.object.isRequired
};

export default Router;
