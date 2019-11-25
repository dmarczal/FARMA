import React, { Component } from 'react';
import {
  grey,
  green,
} from '@material-ui/core/colors';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core';

class ProgressBar extends Component {
  render () {
    let {
      classes,
      completedPercent,
      viewedPercent,
      width,
    } = this.props;

    let completedWidth = completedPercent * width / 100;
    let viewedWidth = viewedPercent * width / 100;

    return (
      <div style={{ width }} className={classes.bar}>
        <div style={{ width: completedWidth }} className={classes.completedBar}/>
        <div style={{ width: viewedWidth }} className={classes.viewedBar}/>
      </div>
    );
  }
}

const styles = {
  bar: {
    width: '100%',
    height: '8px',
    borderRadius: '10px',
    backgroundColor: grey[500],
    position: 'relative',
    zIndex: 1,
  },

  completedBar: {
    height: '8px',
    borderRadius: '10px',
    backgroundColor: green[600],
    position: 'absolute',
    zIndex: 3,
  },

  viewedBar: {
    height: '8px',
    borderRadius: '10px',
    backgroundColor: green['A200'],
    position: 'absolute',
    zIndex: 2,
  },
};

ProgressBar.propTypes = {
  classes:          PropTypes.object.isRequired,
  completedPercent: PropTypes.number.isRequired,
  viewedPercent:    PropTypes.number.isRequired,
  width:            PropTypes.number.isRequired,
};

export default withStyles(styles)(ProgressBar);
