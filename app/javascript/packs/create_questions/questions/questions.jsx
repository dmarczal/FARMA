import React from 'react';
import PropTypes from 'prop-types'

import Question from '../question';

export const serializeQuestions = function (data) {
  return { ...data, correctAnswer: data.correct_answer };
}

class Questions extends React.Component {
  render() {
    let { questions } = this.props;

    return (
      <ul className="questions collapsible">
        {questions.map((question, index) =>
          <Question
            key={question.id}
            exerciseId={this.props.exerciseId}
            index={index}
            question={serializeQuestions(question)}
            onRemove={this.props.onRemove}
          />
        )}
      </ul>
    )
  }
}

Questions.propTypes = {
  questions: PropTypes.array.isRequired,
  onRemove: PropTypes.func.isRequired,
}

export default Questions;
