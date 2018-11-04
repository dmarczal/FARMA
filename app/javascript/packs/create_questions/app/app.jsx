import React from 'react';
import iziToast from 'izitoast';

import Questions from '../questions';
import FormQuestion from '../form-question';
import {
  postQuestion,
  allQuestions,
  putQuestion,
} from '../services/question_service';

class App extends React.Component {
  constructor(props) {
    super(props);

    this.newQuestion = {
      title: '',
      content: '',
      correctAnswer: '',
      precision: 1,
    }

    this.state = {
      errors: {},
      questions: [],
      question: this.newQuestion,
      openForm: false,
      currentIndex: null,
    }

    this.handleCreateQuestion = this.handleCreateQuestion.bind(this);
    this.handleRemoveQuestion = this.handleRemoveQuestion.bind(this);
    this.handelNewQuestion = this.handelNewQuestion.bind(this);
    this.handleEditQuestion = this.handleEditQuestion.bind(this);
    this.handeUpdateQuestion = this.handeUpdateQuestion.bind(this);
    this.handleCloseForm = this.handleCloseForm.bind(this);
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

  handleCloseForm() {
    this.setState({
      question: this.newQuestion,
      currentIndex: null,
      openForm: false,
    })
  }

  handleEditQuestion(question, index) {
    this.setState({
      question,
      currentIndex: index,
      openForm: true,
    });
  }

  handelNewQuestion() {
    this.setState({ openForm: true });
  }

  handleRemoveQuestion(indexRemove) {
    let questions = this.state.questions.filter((question, index) => index != indexRemove);
    this.setState({ questions });
  }

  handeUpdateQuestion(data) {
    putQuestion(
      data,
      this.props.exerciseId,
      this.state.question.id
    ).then(
      (response) => {
        let { data } = response;
        let { questions,currentIndex } = this.state;

        iziToast.success({
          title: 'Sucesso',
          message: `Passo ${data.title} atualizado com sucesso`,
          position: 'topRight',
        });

        questions[currentIndex] = data;

        this.setState({
          currentIndex: null,
          openForm: false,
          question: this.newQuestion,
          questions: questions,
        });
      },
      (response) => {
        let { error } = response;

        iziToast.error({
          title: 'Erro',
          message: `Falha ao atualizar o passo`,
          position: 'topRight',
        });

        this.setState({errors: {...error, correctAnswer: error.correct_answer}});
      }
    )
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

  formComponent() {
    let {
      question,
      openForm,
      errors,
      currentIndex,
    } = this.state;

    let onClick = currentIndex === null ? this.handleCreateQuestion : this.handeUpdateQuestion;
    let actionText = currentIndex === null ? 'Criar passo' : 'Atualizar passo';

    return <FormQuestion
      onClick={onClick}
      errors={errors}
      actionText={actionText}
      onClose={this.handleCloseForm}
      visible={openForm}
      {...question}
    />
  }

  btnComponent() {
    let { openForm } = this.state;

    return !openForm ?
      <div className="fixed-action-btn">
        <button onClick={this.handelNewQuestion} className="btn-floating btn-large waves-effect waves-light red">
          <i className="material-icons">add</i>
        </button>
      </div>
      :
      '';
  }

  render() {
    return (
      <React.Fragment>
        {this.formComponent()}
        <Questions
          questions={this.state.questions}
          exerciseId={this.props.exerciseId}
          onRemove={this.handleRemoveQuestion}
          onEdit={this.handleEditQuestion}
          openForm={this.state.openForm}
        />
        {this.btnComponent()}
      </React.Fragment>
    );
  }
}

export default App;
