import React from 'react';
import PropTypes from 'prop-types';
import iziToast from 'izitoast';

import Component from './component';
import { deleteQuestion, resetTries } from '../services/question_service';
import {
  postTip,
  allTips,
  deleteTip,
  putTip,
} from '../services/tip_service';

const sortTips = (tips) => {
  let newTips = tips;

  newTips.sort((t1, t2) => t1.number_of_tries - t2.number_of_tries);

  return newTips;
}

class Question extends React.Component {
  constructor(props) {
    super(props);

    this.newTip = {
      content: '',
      numberOfTries: 1,
    }

    this.state = {
      tips: [],
      formTipOpen: false,
      currentTip: this.newTip,
      currentIndex: null,
      errors: {},
    };

    this.handleOpenContent = this.handleOpenContent.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
    this.handleOnEdit = this.handleOnEdit.bind(this);
    this.handleAddTip = this.handleAddTip.bind(this);
    this.handleClose = this.handleClose.bind(this);
    this.handleSubmitTip = this.handleSubmitTip.bind(this);
    this.handeEditTip = this.handeEditTip.bind(this);
    this.handleDeleteTip = this.handleDeleteTip.bind(this);
  }

  handleAddTip() {
    this.setState({ formTipOpen: true });
  }

  handleClose() {
    this.setState({
      formTipOpen: false,
      currentTip: this.newTip,
    });
  }

  handleDeleteTip(indexRemove) {
    let { exerciseId, question } = this.props;
    let tip = this.state.tips[indexRemove];

    deleteTip(exerciseId, question.id, tip.id)
      .then(
        (response) => {
          let { data } = response;
          let tips = this.state.tips.filter((tip, index) => index != indexRemove);

          iziToast.success({
            title: 'Sucesso',
            message: data,
            position: 'topRight',
          });

          this.setState({ tips });
        },
        () => {
          iziToast.error({
            title: 'Erro',
            message: `Falha ao deletar a dica`,
            position: 'topRight',
          });
        }
      );
  }

  handeEditTip(index) {
    let tip = this.state.tips[index];

    this.setState({
      formTipOpen: true,
      currentTip: {...tip, numberOfTries: tip.number_of_tries},
      currentIndex: index,
    })
  }

  handleSubmitTip(data) {
    let { exerciseId, question } = this.props;
    let { currentTip } = this.state;

    if (currentTip.id) {
      this.updateTip(data, exerciseId, question.id, currentTip.id);
    } else {
      this.createTip(data, exerciseId, question.id);
    }
  }

  updateTip(data, exerciseId, questionId, tipId) {
    putTip(data, exerciseId, questionId, tipId)
      .then(
        (response) => {
          let { data } = response;
          let { tips, currentIndex } = this.state;

          iziToast.success({
            title: 'Sucesso',
            message: 'Dica atualizada com sucesso',
            position: 'topRight',
          });

          tips[currentIndex] = data;

          this.setState({
            tips: sortTips(tips),
            formTipOpen: false,
            currentIndex: null,
            currentTip: this.newTip,
          });
        },
        (response) => {
          let { error } = response;

          iziToast.error({
            title: 'Erro',
            message: `Falha ao atualizar a dica`,
            position: 'topRight',
          });

          this.setState({errors: {...error, numberOfTries: error.number_of_tries}});
        }
      )
  }

  createTip(data, exerciseId, questionId) {
    postTip(data, exerciseId, questionId)
      .then(
        (response) => {
          let { data } = response;
          let { tips } = this.state;

          iziToast.success({
            title: 'Sucesso',
            message: 'Dica criada com sucesso',
            position: 'topRight',
          });

          tips.push(data);

          this.setState({
            tips: sortTips(tips),
            formTipOpen: false,
            currentTip: this.newTip,
          });
        },
        (response) => {
          let { error } = response;

          iziToast.error({
            title: 'Erro',
            message: `Falha ao criar a dica`,
            position: 'topRight',
          });

          this.setState({errors: {...error, numberOfTries: error.number_of_tries}});
        }
      )
  }

  handleOpenContent() {
    let { exerciseId, question } = this.props;

    $('.collapsible').collapsible('open', this.props.index);
    resetTries(exerciseId, question.id);
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

  componentWillMount() {
    let { exerciseId, question } = this.props;

    allTips(exerciseId, question.id)
      .then(
        (response) => {
          let { data } = response;

          this.setState({ tips: data })
        },
        () => {
          iziToast.error({
            title: 'Erro',
            message: `Falha ao caregar as dicas`,
            position: 'topRight',
          });
        }
      )
  }

  render() {
    let {
      formTipOpen,
      tips,
      errors,
      currentTip,
    } = this.state;

    let { exerciseId, question } = this.props;

    return (
      <Component
        index={this.props.index + 1}
        onOpenContent={this.handleOpenContent}
        onDelete={this.handleDelete}
        onEdit={this.handleOnEdit}
        openForm={this.props.openForm}
        tips={tips}
        onAddTip={this.handleAddTip}
        formTipOpen={formTipOpen}
        errors={errors}
        onClose={this.handleClose}
        onSubmitTip={this.handleSubmitTip}
        currentTip={currentTip}
        onEditTip={this.handeEditTip}
        onRemoveTip={this.handleDeleteTip}
        exerciseId={exerciseId}
        questionId={question.id}
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
