import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {
  TextFormat,
  FormatListBulleted,
} from '@material-ui/icons';
import Layout from './Layout';
import LinkSideBar from './Layout/LinkSideBar';
import Exercise from './scenes/Exercise';
import Introduction from './scenes/Introduction';

class Root extends Component {
  getContent () {
    let { content } = this.props;

    if (content.type === 'Exercise') {
      return <Exercise data={content.data} />;
    }

    return <Introduction data={content.data} />;
  }

  getLinks() {
    let { content } = this.props;

    return content.links.map(link => {
      let primary = 'Introdução ' + link.position;
      let icon = <TextFormat />;
      let secondary = '';

      if (link.type === 'Exercise') {
        primary = 'Execício ' + link.position;
        icon = <FormatListBulleted />;
        secondary = <LinkSideBar steps={link.steps}/>
      }

      return {
        primary,
        icon,
        secondary,
        ...link
      }
    });
  }

  render () {
    return (
      <Layout sideLinks={this.getLinks()}>
        {this.getContent()}
      </Layout>
    );
  }
}

Root.propTypes = {
  content: PropTypes.object.isRequired,
};

export default Root;
