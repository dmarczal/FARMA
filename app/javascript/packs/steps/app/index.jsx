import React from 'react';
import { ThemeProvider } from '@material-ui/styles';
import { createMuiTheme } from '@material-ui/core/styles';
import { green } from '@material-ui/core/colors';

import Steps from './scenes/steps';

const theme = createMuiTheme({
  palette: {
    primary: { main: green[500] }
  },
});

export default () => {
  return (
    <ThemeProvider theme={theme}>
      <Steps />
    </ThemeProvider>
  );
}
