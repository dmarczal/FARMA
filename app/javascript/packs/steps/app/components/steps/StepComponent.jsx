import React from 'react';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/core/styles';

import {
  green,
  red,
  grey,
  yellow
} from '@material-ui/core/colors';

import {
  ExpandMore,
  ExpandLess,
  Delete,
  Create,
  EmojiObjects,
} from '@material-ui/icons';

import {
  Collapse,
  Paper,
  Typography,
  Grid,
  Divider,
  Box,
  Button,
} from '@material-ui/core';

const styles = makeStyles(theme => ({
  root: {
    minHeight: '80px',
    padding: '5px 10px',
    marginTop: '20px',
  },
  expandMore: {
    color: green['A400'],
    cursor: 'pointer'
  },
  actions: {
    cursor: 'pointer'
  },
  box: {
    height: '100%',
  },
  header: {
    color: red[300]
  },
  title: {
    color: grey[700],
    padding: '0 20px',
  },
  boxResponse: {
    margin: '10px',
    padding: '5px 10px',
    border: '0.8px solid',
    borderColor: grey[300],
    display: 'inline-block',
  },
  boxDesc: {
    color: grey[700],
    margin: '10px',
  },
  tips: {
    backgroundColor: yellow[700],
    borderColor: yellow[700],
    width: '90%',
    margin: '10px',
    '&:hover': {
      backgroundColor: yellow[800],
    },
    '&:focus': {
      backgroundColor: yellow[800],
    },
    '&:active': {
      backgroundColor: yellow[600],
    },
  }
}));

const StepComponent = ({
  openCollapse,
  number,
  title,
  onOpen,
}) => {
  const classes = styles();

  let openIcon = openCollapse ?
    (<ExpandLess
      className={classes.expandMore}
      color="action"
      onClick={onOpen}
    />)
    :
    (<ExpandMore
      className={classes.expandMore}
      color="action"
      onClick={onOpen}
    />);

  return (
    <Paper className={classes.root}>
      <Grid container spacing={0} className={classes.box}>
        <Grid item xs={9}>
          <Typography
            variant="h5"
            component="h3"
            className={classes.header}
          >
            {number} PASSO
          </Typography>
        </Grid>
        <Grid item xs={3}>
          <Grid
            container
            direction="row"
            justify="flex-end"
            alignItems="flex-start"
            spacing={3}
          >
            <Grid item>
              <Create color="action" className={classes.actions}/>
            </Grid>
            <Grid item>
              <Delete color="action" className={classes.actions}/>
            </Grid>
          </Grid>
        </Grid>
        <Grid item xs={12} className={classes.title}>
          <Typography component="p">
            {title}
          </Typography>
        </Grid>
        <Grid item xs={12}>
          <Grid
            container
            direction="row"
            justify="center"
            alignItems="flex-end"
          >
            <Grid item>
              {openIcon}
            </Grid>
          </Grid>
        </Grid>
      </Grid>
      <Collapse
        timeout="auto"
        in={openCollapse}
      >
        <Divider />
        <Grid container spacing={0}>
          <Grid item xs={12} md={9}>
            <Box className={classes.boxDesc}>
              Descrição
            </Box>
            <Typography component="span">
              RESPOSTA:
            </Typography>
            <Box className={classes.boxResponse}>
              $2+x^2$
            </Box>
          </Grid>
          <Grid item xs={12} md={3}>
            <Button variant="contained" className={classes.tips}>
              <EmojiObjects /> Dicas
            </Button>
          </Grid>
        </Grid>
      </Collapse>
    </Paper>
  );
}

StepComponent.propTypes = {
  openCollapse: PropTypes.bool.isRequired,
  number: PropTypes.number.isRequired,
  title: PropTypes.string.isRequired,
  onOpen: PropTypes.func.isRequired,
}

export default StepComponent;
