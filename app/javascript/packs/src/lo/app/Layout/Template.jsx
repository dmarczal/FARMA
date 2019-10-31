import React from 'react';
import PropTypes from 'prop-types';
import MenuIcon from '@material-ui/icons/Menu';
import {
  Check,
  Visibility,
  AssistantPhoto,
  ArrowDropDown,
} from '@material-ui/icons';
import clsx from 'clsx';
import {
  AppBar,
  Toolbar,
  IconButton,
  Drawer,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  Menu,
  MenuItem,
  Button,
  Avatar,
  Typography,
  Grid,
} from '@material-ui/core';
import { green } from '@material-ui/core/colors';

import ProgressBar from './ProgressBar';
import styles from './styles';
import logo from './logo.png';

const Template = ({
  isOpenSide,
  children,
  onToggleSide,
  sideLinks,
}) => {
  const classes = styles();
  let [avatarEl, setAvatarEl] = React.useState(null);
  let [progressEl, setProgressEl] = React.useState(null);

  const handleOpenAvatar = event => {
    setAvatarEl(event.currentTarget);
  };

  const handleCloseAvatar = () => {
    setAvatarEl(null);
  };

  const handleOpenProgress = event => {
    setProgressEl(event.currentTarget);
  };

  const handleCloseProgress = () => {
    setProgressEl(null);
  };

  return (
    <div className={classes.root}>
      <AppBar className={classes.appBar} position="fixed">
        <Toolbar>
          <IconButton
            edge="start"
            color="inherit"
            aria-label="open drawer"
            className={classes.menuButton}
            onClick={onToggleSide}
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" component="h6" className={classes.title}>
            h6. Heading
          </Typography>
          <a href="/" className={classes.logo}>
            <img
              src={logo}
              alt="logo-farma"
              className={classes.logo}
            />
          </a>
          <Button className={classes.progressBarButton} onClick={handleOpenProgress}>
            <ProgressBar completedPercent={50} viewedPercent={70} width={200} />
          </Button>
          <Menu
            keepMounted
            open={Boolean(progressEl)}
            onClose={handleCloseProgress}
            anchorEl={progressEl}
            className={classes.avatarDrop}
          >
            <MenuItem>
              <Grid container spacing={0}>
                <Grid item xs={3}>
                  <Check
                    color="inherit"
                    fontSize="large"
                    className={classes.iconCheck}
                  />
                </Grid>
                <Grid item xs={9}>
                  <Typography component="p">
                    70% do OA Concluído
                  </Typography>
                </Grid>
                <Grid item xs={12}>
                  <Typography className={classes.barDescription}>
                    Conteúdo respondido
                  </Typography>
                </Grid>
              </Grid>
            </MenuItem>
            <MenuItem>
              <Grid container spacing={0}>
                <Grid item xs={3}>
                  <Visibility
                    color="inherit"
                    fontSize="large"
                    className={classes.iconVisibility}
                  />
                </Grid>
                <Grid item xs={9}>
                  <Typography component="p">
                    70% do OA Concluído
                  </Typography>
                </Grid>
                <Grid item xs={12}>
                  <Typography className={classes.barDescription}>
                    Conteúdo somente visualizado
                  </Typography>
                </Grid>
              </Grid>
            </MenuItem>
            <MenuItem>
              <Grid container spacing={0}>
                <Grid item xs={3}>
                  <AssistantPhoto
                    color="inherit"
                    fontSize="large"
                    className={classes.iconAssistantPhoto}
                  />
                </Grid>
                <Grid item xs={9}>
                  <Typography component="p">
                    70% do OA Concluído
                  </Typography>
                </Grid>
                <Grid item xs={12}>
                  <Typography className={classes.barDescription}>
                    Conteúdo não visualizado
                  </Typography>
                </Grid>
              </Grid>
            </MenuItem>
          </Menu>
          <Button aria-controls="simple-menu" aria-haspopup="true" onClick={handleOpenAvatar}>
            <Avatar alt="Avatar" src={logo} className={classes.avatar}/>
             Open Menu
            <ArrowDropDown />
          </Button>
          <Menu
            keepMounted
            open={Boolean(avatarEl)}
            onClose={handleCloseAvatar}
            anchorEl={avatarEl}
            className={classes.avatarDrop}
          >
            <MenuItem onClick={handleCloseAvatar}>Profile</MenuItem>
            <MenuItem onClick={handleCloseAvatar}>My account</MenuItem>
            <MenuItem onClick={handleCloseAvatar}>Logout</MenuItem>
          </Menu>
        </Toolbar>
      </AppBar>
      <Drawer
        className={clsx(classes.drawer, {
          [classes.drawerOpen]: isOpenSide,
          [classes.drawerClose]: !isOpenSide,
        })}
        variant="permanent"
        classes={{
          paper: clsx({
            [classes.drawerOpen]: isOpenSide,
            [classes.drawerClose]: !isOpenSide,
          }),
        }}
        open={false}
      >
        <div className={classes.toolbar} />
        <List>
          {sideLinks.map((link) => (
            <ListItem
              button
              key={link.id}
              style={{borderLeft: '4px solid ' + (link.active ? green[300] : 'transparent')}}
            >
              <ListItemIcon>{link.icon}</ListItemIcon>
              <ListItemText
                primary={link.primary}
                secondary={link.secondary}
                className={clsx({[classes.hide]: !isOpenSide})}
                primaryTypographyProps={{className: classes.sideText}}
                secondaryTypographyProps={{component: 'div', className: classes.sideText}}
              />
            </ListItem>
          ))}
        </List>
      </Drawer>
      <main className={classes.content}>
        <div className={classes.toolbar} />
        {children}
      </main>
    </div>
  )
};

Template.propTypes = {
  isOpenSide: PropTypes.bool.isRequired,
  children: PropTypes.element.isRequired,
  onToggleSide: PropTypes.func.isRequired,
  sideLinks: PropTypes.array.isRequired,
};

export default Template;
