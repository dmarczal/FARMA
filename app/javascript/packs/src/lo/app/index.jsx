import React, { Component } from 'react';
import Root from './Root';
import Http from '../../libs/Http';
import { PulseLoader } from 'react-spinners';

class Page extends Component {
  constructor (props) {
    super (props);
    let http = new Http(this.getPath());
    let page = props.page || 1;

    this.state = {
      http,
      content: {},
      isLoad: true,
      page,
    };

    this.load = this.load.bind(this);
    this.back = this.back.bind(this);
    this.handleCreateAnswer = this.handleCreateAnswer.bind(this);
    this.load(page);
  }

  componentDidMount () {
    window.onpopstate = (event) => {
      let { page } = event.state;
      this.load(page, false);
    }
  }

  getPath () {
    let { type, teamId, loId } = this.props;

    switch (type) {
      case 'student':
        return `/api/team/${teamId}/contents`;
      case 'teacher':
        return `/api/lo/${loId}/contents`;
      default:
        break;
    }
  }

  getAnswerPath (exerciseId, questionId) {
    let { type, teamId, loId } = this.props;

    switch (type) {
      case 'student':
        return `/api/team/${teamId}/exercise/${exerciseId}/questions/${questionId}`;
      case 'teacher':
          return `/api/lo/${loId}/exercise/${exerciseId}/questions/${questionId}`;
      default:
        break;
    }
  }

  handleCreateAnswer (exerciseId, questionId, response, answer_tex) {
    let { isLoad, page } = this.state;
    let path = this.getAnswerPath(exerciseId, questionId);
    let http = new Http(path);

    if (!isLoad) {
      this.setState({ isLoad: true });
    }

    http.post('/answers', { response, answer_tex, page })
      .then(({ data }) => {
        this.setState({ content: data, isLoad: false });
      })
      .catch(console.warn);
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
        this.setState({ content: data, isLoad: false, page });
      })
      .catch(console.warn);
  }

  render () {
    let { content, isLoad } = this.state;
    let { loName, userName, userImage } = this.props;
    let pageContent = <PulseLoader />;

    if (!isLoad) {
      pageContent = <Root
        content={content}
        onClickLink={this.load}
        loName={loName}
        userName={userName}
        userImage={userImage}
        back={this.back}
        onCreateAnswer={this.handleCreateAnswer}
      />
    }

    return pageContent;
  }
}

export default Page;
