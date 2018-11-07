import React from 'react';
import renderHtml from 'react-render-html';
import { Keyboard } from 'react-material-keyboard';
import MathJax from 'react-mathjax';

import { createAnswer } from '../services/question_service';

class Question extends React.Component {
  constructor(props) {
    super(props);

    let { data } = props;

    this.state = {
      answers: data.answers,
      tips: data.tips,
      title: data.question.title,
      content: data.question.content,
      id: data.question.id,
      newTip: '',
    }

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(response) {
    let { teamId, exerciseId, onChangeProgress } = this.props;
    let { id } = this.state;
    let data = { response }

    createAnswer(data, teamId, exerciseId, id)
      .then(
        response => {
          let { answer, progress, tips } = response.data;
          let { answers } = this.state;
          let isMoreTips = this.state.tips.length < tips.length;

          onChangeProgress(progress);

          answers.push(answer);

          this.setState({
            answers,
            tips,
            newTip: isMoreTips ? 'active' : '',
          })
        },
        response => console.log(response)
      )
  }

  lastAnswer() {
    let { answers } = this.state;

    if (answers.length == 0) return null;

    return answers[answers.length - 1];
  }

  renderAnswers() {
    let { answers, id } = this.state;

    let showAnswers = answers.slice(0, -1).reverse();

    if (showAnswers.length === 0) return '';

    return (
      <React.Fragment>
        <button
          className="btn-floating btn-large waves-effect waves-light red answer-open"
          onClick={() => $(`#answers-${id}`).slideToggle()}
        >
          {answers.length}
        </button>
        <MathJax.Provider>
          <ul id={`answers-${id}`} className="collection answers z-depth-1">
            {showAnswers.map(answer => (
              <li
                key={answer.id}
                className={'collection-item ' + (answer.correct ? 'valid' : 'has-error')}
              >
                <MathJax.Node formula={answer.response}/>
              </li>
            ))}
          </ul>
        </MathJax.Provider>
      </React.Fragment>
    )
  }

  render() {
    let lastAnswer = this.lastAnswer();
    let {
      title,
      content,
      id,
      tips,
      newTip,
    } = this.state;

    let response =  null;
    var classAnswer = '';

    if (lastAnswer != null) {
      classAnswer =  lastAnswer.correct ? 'valid' : 'has-error';
      response = lastAnswer.response;
    }

    return (
      <div className="row">
        <div className="col s8">
          <div className="paper-sheet z-depth-1">
            <i
              className={`fa fa-lightbulb-o right btn-icon fa-2x ${newTip}`}
              onClick={() => {
                $(`#tips-${id}`).fadeToggle();
                this.setState({ newTip: '' });
              }}
            />
            <span>Passo {this.props.index + 1}</span>
            <h2 className="title">{title}</h2>

            {renderHtml(content)}
          </div>
          <div className={classAnswer}>
            <Keyboard
              onSubmit={this.handleSubmit}
              value={response}
            />
          </div>
          {this.renderAnswers()}
        </div>

        <div className="col s4">
          <div id={`tips-${id}`} className="paper-sheet z-depth-1 tips">
            <h4 className="title center-align"><i className="fa fa-lightbulb-o"/> Dicas</h4>
            {tips.map((tip, index) => (
              <div key={tip.id} className="tip">
                <span>{index + 1}ª Dica</span>
                {renderHtml(tip.content)}
              </div>
            ))}
          </div>
        </div>
      </div>
    )
  }
}

export default Question;
