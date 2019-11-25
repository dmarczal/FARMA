import { createMuiTheme } from '@material-ui/core/styles';
import { grey, green, red } from '@material-ui/core/colors';

const palette = {
  primary: grey,
  secondary: green,
  error: red,
}

export default createMuiTheme({
  palette: {
    primary: {
      main: palette.primary[50]
    },
    secondary: {
      light: palette.secondary.A400,
      main:  palette.secondary[400],
      dark: palette.secondary[900],
    },
    error: {
      light: palette.error.A200,
      main:  palette.error[400],
      dark: palette.error[800],
    }
  },
});
