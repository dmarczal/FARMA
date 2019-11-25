import { grey, red, green } from '@material-ui/core/colors';
import { makeStyles } from '@material-ui/core/styles';

export default makeStyles(theme => ({
  rootPaper: {
    paddingLeft: theme.spacing(6),
    paddingRight: theme.spacing(6),
    paddingTop: theme.spacing(3),
    paddingBottom: theme.spacing(3),
    color: grey[700],
  },

  step: {
    position: 'relative',
    paddingLeft: theme.spacing(6),
    paddingRight: theme.spacing(6),
    paddingTop: theme.spacing(3),
    paddingBottom: theme.spacing(3),
    borderRadius: 0,
    borderTopLeftRadius: 4,
    borderTopRightRadius: 4,
    color: grey[700],
  },

  responsePaper: {
    cursor: 'pointer',
    borderRadius: 0,
    borderBottomLeftRadius: 4,
    borderBottomRightRadius: 4,
    padding: theme.spacing(1),
    zIndex: 1,
  },

  response: {
    marginTop: 20,
    textAlign: 'center',
    border: '2px solid',
    position: 'relative',
    zIndex: 1,
  },

  responseEmpty: {
    textAlign: 'center',
    zIndex: 1,
  },

  status: {
    zIndex: '2',
    top: '-12px',
    left: '20px',
    padding: '0 10px',
    margin: 0,
    position: 'absolute',
    background: 'white',
    zIndex: 1,
  },

  marginGrid: {
    marginBottom: theme.spacing(3),
    position: 'relative',
    zIndex: 1,
  },

  btnResponses: {
    position: 'absolute',
    backgroundColor: red[600],
    left: 10,
    zIndex: 2,
    marginTop: "-20px",

    '&:hover': {
        backgroundColor: red[900],
    },
  },

  keyboardBox: {
    position: 'fixed',
    width: '100vw',
    height: '100%',
    left: 0,
    top: 0,
    zIndex: theme.zIndex.drawer + 2,
    backgroundColor: 'rgba(0, 0, 0, 0.3)',
  },

  keyboardClose: {
    position: 'fixed',
    right: 50,
    top: 50,
    cursor: 'pointer',
    color: green[100],
  },

  table: {
    paddingTop: 25,
    backgroundColor: 'white',
  },

  tips: {
    textAlign: 'center',
    marginBottom: 10,
  },

  tipRight: {
    float: 'right',
  },

  tipLeft: {
    float: 'left',
  },

  tipShow: {
    position: 'absolute',
    top: 10,
    right: 10,
    cursor: 'pointer',
  }
}));
