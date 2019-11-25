import React from 'react';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/core/styles';

import {
  green,
  red,
  grey,
} from '@material-ui/core/colors';

import {
  ExpandMore,
  ExpandLess,
  Delete,
  Create,
} from '@material-ui/icons';

import {
  Collapse,
  Paper,
  Typography,
  Grid,
  Divider,
  Box,
} from '@material-ui/core';

const styles = makeStyles(theme => ({
  root: {
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
  boxDesc: {
    color: grey[700],
    margin: '10px',
  },
}));

const TipComponent = ({
  openCollapse,
  number,
  data,
  onOpen,
  onEdit,
  onDelete,
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
            DICA {number}
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
                onClick={() => onEdit(data)}
              />
            </Grid>
            <Grid item>
              <Delete
                color="action"
                className={classes.actions}
                onClick={() => onDelete(data.id)}
              />
            </Grid>
          </Grid>
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
          <Grid item xs={12}>
            <Box className={classes.boxDesc}>
              <div dangerouslySetInnerHTML={{ __html: data.content }}></div>
            </Box>
            <Typography component="span">
              Quantidade de tentativas: {data.number_of_tries}
            </Typography>
          </Grid>
        </Grid>
      </Collapse>
    </Paper>
  );
}

TipComponent.propTypes = {
  openCollapse: PropTypes.bool.isRequired,
  number: PropTypes.number.isRequired,
  onOpen: PropTypes.func.isRequired,
  onEdit: PropTypes.func.isRequired,
  onDelete: PropTypes.func.isRequired,
  data: PropTypes.object.isRequired,
}

export default TipComponent;
