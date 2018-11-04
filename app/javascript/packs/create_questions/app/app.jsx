import React from 'react';
import iziToast from 'izitoast';

import Questions from '../questions';
import FormQuestion from '../form-question';
import { postQuestion, allQuestions } from '../services/question_service';

class App extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      errors: {},
      questions: [],
    }

    this.handleCreateQuestion = this.handleCreateQuestion.bind(this);
    this.handleRemoveQuestion = this.handleRemoveQuestion.bind(this);
  }

  componentWillMount() {
    allQuestions(this.props.exerciseId).then(
      (response) => this.setState({questions: response.data}),
      () => iziToast.error({
        title: 'Erro',
        message: `Falha ao carregar as questões`,
        position: 'topRight',
      })
    );
  }

  handleRemoveQuestion(indexRemove) {
    let questions = this.state.questions.filter((question, index) => index === indexRemove);
    this.setState({ questions });
  }

  handleCreateQuestion(data) {
    postQuestion(data, this.props.exerciseId).then(
      (response) => {
        let { data } = response;

        iziToast.success({
          title: 'Sucesso',
          message: `Passo ${data.title} criado com sucesso`,
          position: 'topRight',
        });
      },
      (response) => {
        let { error } = response;

        iziToast.error({
          title: 'Erro',
          message: `Falha ao criar o passo`,
          position: 'topRight',
        });

        this.setState({errors: {...error, correctAnswer: error.correct_answer}});
      }
    )
  }

  render() {
    return (
      <React.Fragment>
        <Questions
          questions={this.state.questions}
          exerciseId={this.props.exerciseId}
          onRemove={this.handleRemoveQuestion}
        />
      </React.Fragment>
    );
  }
}

export default App;
