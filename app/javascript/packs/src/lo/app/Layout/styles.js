import {
  grey,
  green,
} from '@material-ui/core/colors';
import { makeStyles } from '@material-ui/core/styles';

export default makeStyles(theme => ({
  root: {
    display: 'flex',
    background: grey[200],
    width: '100%',
  },
  appBar: {
    zIndex: theme.zIndex.drawer + 1,
  },
  drawer: {
    width: 240,
    flexShrink: 0,
  },
  drawerOpen: {
    width: 240,
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  drawerClose: {
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
    overflowX: 'hidden',
    width: theme.spacing(7),
  },
  menuButton: {
    marginRight: 36,
  },
  hide: {
    display: 'none',
  },
  content: {
    marginLeft: theme.spacing(1),
    marginRight: theme.spacing(1),
    padding: theme.spacing(2),
    width: '100%',
  },
  toolbar: theme.mixins.toolbar,
  logo: {
    display: 'block',
    margin: '0 auto',
    width: 50,
    height: 50
  },
  avatar: {
    marginRight: 15
  },
  title: {
    width: 300,
  },
  progressBarButton: {
    height: 50,
  },
  avatarDrop: {
    marginTop: 47,
  },
  barDescription: {
    fontSize: '0.7rem',
    color: grey[500],
    textAlign: 'center',
  },
  iconCheck: {
    color: green[600],
  },
  iconVisibility: {
    color: green['A200'],
  },
  iconAssistantPhoto: {
    color: grey[500],
  },
  sideText: {
    fontSize: 12,
  },
}));
