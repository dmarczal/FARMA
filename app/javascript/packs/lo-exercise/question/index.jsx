import React from 'react';
import renderHtml from 'react-render-html';
import { Keyboard } from 'react-material-keyboard';

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
    }

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit() {

  }

  lastAnswer() {
    let { answers } = this.state;

    if (answers.length == 0) return null;

    return answers[answers.length - 1];
  }

  render() {
    let lastAnswer = this.lastAnswer();
    let { title, content, id } = this.state;

    return (
      <div className="row">
        <div className="col s8">
          <div className="paper-sheet z-depth-1">
            <i className="fa fa-lightbulb-o right btn-icon fa-2x" onClick={() => $(`#tips-${id}`).fadeToggle()} />
            <span>Passo {this.props.index + 1}</span>
            <h2 className="title">{title}</h2>

            {renderHtml(content)}
          </div>
          <Keyboard
            onSubmit={this.handleSubmit}
            value={lastAnswer}
          />
        </div>

        <div className="col s4">
          <div id={`tips-${id}`} className="paper-sheet z-depth-1 tips">
            <h4 className="title center-align"><i className="fa fa-lightbulb-o"/> Dicas</h4>
          </div>
        </div>
      </div>
    )
  }
}

export default Question;
