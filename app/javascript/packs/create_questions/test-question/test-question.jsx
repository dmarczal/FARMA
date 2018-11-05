import React from 'react';
import { Keyboard } from 'react-material-keyboard';

import { testQuestion } from '../services/question_service';
import Tip from './tip';

class TestQuestion extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      classError: '',
      value: null,
      tips: [],
    }

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(response) {
    let data = { response }
    let { questionId, exerciseId } = this.props;

    testQuestion(data, exerciseId, questionId)
      .then(
        response => {
          let { data } = response;
          let classError = data.answer.correct ? 'valid' : 'has-error';
          let value = data.answer.response;
          let { tips } = data;

          if (!tips) tips = [];

          this.setState({ classError, value, tips });
        },
        response => console.log(response)
      )
  }

  renderTips() {
    let { tips } = this.state;
    if (tips.length == 0) return '';

    return (
      <div className="col s12 l6 tips z-depth-1">
        <div className="center-align">
          <i className="material-icons">lightbulb_outline</i> Dicas
        </div>
        {tips.map((tip, index) => <Tip key={tip.id} index={index + 1} content={tip.content}/>)}
      </div>
    )
  }

  render () {
    let { classError, value, tips } = this.state;

    return (
      <div className="row">
        <div className={`col s12 l6 ${classError}`}>
          <Keyboard
            onSubmit={this.handleSubmit}
            value={value}
            screenText="Clique aqui para testar a resposta"
          />
        </div>
        {this.renderTips()}
      </div>
    )
  }
}

export default TestQuestion;
