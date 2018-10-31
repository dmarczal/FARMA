import React from 'react';
import iziToast from 'izitoast';

import FormQuestion from '../form-question';
import { postQuestion } from '../services/question_service';

class Question extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      errors: {}
    }

    this.handleCreateQuestion = this.handleCreateQuestion.bind(this);
  }

  handleCreateQuestion(data) {
    postQuestion(data).then(
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
          title: 'Sucesso',
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
        <FormQuestion
          onClick={this.handleCreateQuestion}
          errors={this.state.errors}
        />
        <p>questions</p>
      </React.Fragment>
    );
  }
}

export default Question;
