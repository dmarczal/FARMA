import React from 'react';

import Question from '../question';
import { getQuestions } from '../services/question_service';

class App extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      data: {},
    }
  }

  handleChangeProgress(progress) {
    if (progress.length == 0) return;

    console.log(progress);
  }

  componentWillMount() {
    let { teamId, exerciseId } = this.props;

    getQuestions(teamId, exerciseId)
      .then(
        response => {
          let { data } = response;

          this.handleChangeProgress(data.progress);
          this.setState({ data });
        },
        response => console.log(response)
      );
  }

  questionRender() {
    let { questions } = this.state.data;

    if (!questions) return "";

    return questions.map((data, index) =>
      <Question key={data.question.id} index={index} data={data} />
    )
  }

  render() {
    return this.questionRender();
  }
}

export default App;
