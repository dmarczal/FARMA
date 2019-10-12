import React from 'react';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/core/styles';
import MathJax from 'react-mathjax';
import { Link } from 'react-router-dom';

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
    padding: '0 10px',
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
  data,
  onOpen,
  onEditStep,
  deleteStep,
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

  let precision = data.precision ?
    (
      <Typography component="span">
        PRECISÃO: {data.precision}
      </Typography>
    ): '';

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
              <Create
                color="action"
                className={classes.actions}
                onClick={() => onEditStep(data)}
              />
            </Grid>
            <Grid item>
              <Delete
                color="action"
                className={classes.actions}
                onClick={() => deleteStep(data.id)}
              />
            </Grid>
          </Grid>
        </Grid>
        <Grid item xs={12} className={classes.title}>
          <Typography component="p">
            {data.title}
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
              <div dangerouslySetInnerHTML={{ __html: data.content }}></div>
            </Box>
            <Typography component="span">
              RESPOSTA:
            </Typography>
            <Box className={classes.boxResponse}>
              <MathJax.Provider>
                <MathJax.Node formula={data.answer_tex} />
              </MathJax.Provider>
            </Box>
            {precision}
          </Grid>
          <Grid item xs={12} md={3}>
            <Button
              component={Link}
              to={`/${data.id}/tips`}
              variant="contained"
              className={classes.tips}
            >
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
  onOpen: PropTypes.func.isRequired,
  onEditStep: PropTypes.func.isRequired,
  deleteStep: PropTypes.func.isRequired,
  data: PropTypes.exact({
    id: PropTypes.number,
    title: PropTypes.string.isRequired,
    content: PropTypes.string.isRequired,
    correct_answer: PropTypes.string.isRequired,
    answer_tex: PropTypes.string.isRequired,
    precision: PropTypes.number,
    variables: PropTypes.array.isRequired,
  }).isRequired,
}

export default StepComponent;
