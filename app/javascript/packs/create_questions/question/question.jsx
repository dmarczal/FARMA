import React from 'react';
import PropTypes from 'prop-types';
import iziToast from 'izitoast';

import Component from './component';
import { deleteQuestion } from '../services/question_service';

class Question extends React.Component {
  constructor(props) {
    super(props);

    this.handleOpenContent = this.handleOpenContent.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
    this.handleOnEdit = this.handleOnEdit.bind(this);
  }

  handleOpenContent() {
    $('.collapsible').collapsible('open', this.props.index);
  }

  handleOnEdit() {
    this.props.onEdit(this.props.question, this.props.index);
  }

  handleDelete() {
    let { exerciseId, question } = this.props;

    deleteQuestion(exerciseId, question.id)
      .then(
        (response) => {
          let { data } = response;

          iziToast.success({
            title: 'Sucesso',
            message: data,
            position: 'topRight',
          });

          this.props.onRemove(this.props.index);
        },
        () => {
          iziToast.error({
            title: 'Erro',
            message: `Falha ao deletar a questão`,
            position: 'topRight',
          });
        }
      );
  }

  render() {
    return (
      <Component
        index={this.props.index + 1}
        onOpenContent={this.handleOpenContent}
        onDelete={this.handleDelete}
        onEdit={this.handleOnEdit}
        openForm={this.props.openForm}
        {...this.props.question}
      />
    )
  }
}

Question.propTypes = {
  index: PropTypes.number.isRequired,
  question: PropTypes.object.isRequired,
  onRemove: PropTypes.func.isRequired,
  onEdit: PropTypes.func.isRequired,
  openForm: PropTypes.bool.isRequired,
}

export default Question;
