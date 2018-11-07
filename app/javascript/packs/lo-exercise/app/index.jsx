import React from 'react';
import { FadeLoader } from 'react-spinners';
import iziToast from 'izitoast';

import Question from '../question';
import { getQuestions } from '../services/question_service';

class App extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      data: {},
      loading: true,
    }
  }

  handleChangeProgress(progress) {
    if (progress == null) return;

    let width_process_bar = $(".bar").width() * progress.progress_percent / 100;
    let width_preview_bar = $(".bar").width() * progress.preview_percent / 100;

    $(".progress-bar").css("width", width_process_bar);
    $(".progress-bar").data("percent", progress.progress_percent);
    $(".view-bar").css("width", width_preview_bar);
    $(".view-bar").data("percent", progress.preview_percent);

    $("#progress_percent .percent").text(progress.preview_percent);
    $("#preview_percent .percent").text(progress.progress_percent);
    $("#not_answered .percent").text(100 - progress.preview_percent);
  }

  componentWillMount() {
    let { teamId, exerciseId } = this.props;

    getQuestions(teamId, exerciseId)
      .then(
        response => {
          let { data } = response;

          this.handleChangeProgress(data.progress);
          this.setState({ data, loading: false });
        },
        () => {
          iziToast.error({
            title: 'Erro',
            message: `Falha ao carregar o exercício`,
            position: 'topRight',
          });

          this.setState({ loading: false });
        }
      );
  }

  questionRender() {
    let { questions } = this.state.data;
    let { teamId, exerciseId } = this.props;

    if (!questions) return "";

    return questions.map((data, index) =>
      <Question
        key={data.question.id}
        index={index}
        data={data}
        teamId={teamId}
        exerciseId={exerciseId}
        onChangeProgress={this.handleChangeProgress}
      />
    )
  }

  render() {
    return (
      <React.Fragment>
        <div style={{position: 'fixed', left: '50%', top: '50%'}}>
          <FadeLoader
            sizeUnit={"px"}
            size={100}
            color={'#36D7B7'}
            loading={this.state.loading}
          />
        </div>
        {this.questionRender()}
      </React.Fragment>
    );
  }
}

export default App;
