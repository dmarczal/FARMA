class Api::QuestionsController < ApplicationController
  def index
    render json: Question.all
  end

  def show
    question = Question.find_by(id: params[:id])
    if question
      render json: question
    else
      render json: {error: "Question does not exist"}
    end

  end

  def create
    question = Question.new(question_params)

    if question.save
      render json: {success: "Question successfully created"}
    else
      render json: {error: "Error creating question"}
    end

  end

  def update

    if Question.update(question_params)
      render json: {success: "Question successfully update"}
    else
      render json: {error: "Error updating question"}
    end
  end

  def destroy
    Question.destroy(params[:id])
  end

  def question_params
    params.permit(:title, :content, :correct_answer)
  end
end
