import React, { Component } from 'react';
import Root from './Root';
import Http from '../../libs/Http';

class Page extends Component {
  constructor (props) {
    super (props);
    let http = new Http(this.getPath());

    this.state = {
      http,
      content: {},
      isLoad: true,
    };

    this.load = this.load.bind(this);
    this.back = this.back.bind(this);
    this.load(1);
  }

  getPath () {
    let { type, teamId } = this.props;

    switch (type) {
      case 'student':
        return `/api/team/${teamId}/contents`;
      default:
        break;
    }
  }

  componentDidMount () {
    window.onpopstate = (event) => {
      let { page } = event.state;
      this.load(page, false);
    }
  }

  back () {
    let { type, teamId } = this.props;

    switch (type) {
      case 'student':
        location.href = '/student/teams/'+teamId;
      default:
        break;
    }
  }

  load (page, pushState = true) {
    let { http, isLoad } = this.state;

    if (pushState) {
      history.pushState({ page }, 'page ' + page, `?page=${page}`);
    }

    if (!isLoad) {
      this.setState({ isLoad: true });
    }

    http.get('/'+page)
      .then(({ data }) => {
        this.setState({ content: data, isLoad: false });
      })
      .catch(console.warn);
  }

  render () {
    let { content, isLoad } = this.state;
    let { loName, userName } = this.props;
    let pageContent = '';

    if (!isLoad) {
      pageContent = <Root
        content={content}
        onClickLink={this.load}
        loName={loName}
        userName={userName}
        back={this.back}
      />
    }

    return pageContent;
  }
}

export default Page;
