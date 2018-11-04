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
      question: {
        title: '',
        content: '',
        correctAnswer: '',
        precision: '',
      },
      openForm: false,
    }

    this.handleCreateQuestion = this.handleCreateQuestion.bind(this);
    this.handleRemoveQuestion = this.handleRemoveQuestion.bind(this);
    this.handelNewQuestion = this.handelNewQuestion.bind(this);
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

  handelNewQuestion() {
    this.setState({ openForm: true });
  }

  handleRemoveQuestion(indexRemove) {
    let questions = this.state.questions.filter((question, index) => index != indexRemove);
    this.setState({ questions });
  }

  handleCreateQuestion(data) {
    postQuestion(data, this.props.exerciseId).then(
      (response) => {
        let { data } = response;
        let { questions } = this.state;

        iziToast.success({
          title: 'Sucesso',
          message: `Passo ${data.title} criado com sucesso`,
          position: 'topRight',
        });

        questions.push(data);

        this.setState({
          openForm: false,
          questions: questions,
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
    let { question, openForm, errors } = this.state;
    let formQuestion = openForm ?
      <FormQuestion
        onClick={this.handleCreateQuestion}
        errors={errors}
        {...question}
      /> : '';

    return (
      <React.Fragment>
        {formQuestion}
        <Questions
          questions={this.state.questions}
          exerciseId={this.props.exerciseId}
          onRemove={this.handleRemoveQuestion}
        />
        <div className="fixed-action-btn">
          <button onClick={this.handelNewQuestion} className="btn-floating btn-large waves-effect waves-light red">
            <i className="material-icons">add</i>
          </button>
        </div>
      </React.Fragment>
    );
  }
}

export default App;
