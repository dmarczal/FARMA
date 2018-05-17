class API::QuestionsController < ApplicationController
  before_action :find_question, except: [:create, :index]
  before_action :find_exercise, only: [:create]

  def index
    render json: Question.all
  end

  def show
    question = Question.find(params[:id])
    render json: question
  end

  def create
    question = @exercise.questions.new(question_params)
    if question.save
      render json: {
          "type": "Question",
          "message": question.title + " criada com sucesso.",
          "data": {
              "title": question.title
          }}
    else
      render json: {
          "type": "Question",
          "message": "Erro ao criar a questão.",
          "data": {
              "title": question.title
          },
          "error_data": {
              "content": question.errors
          }}
    end
  end

  def update
    if @question.update(question_params)
      render json: {
          "type": "Question",
          "message": @question.title + " atualizada com sucesso.",
          "data": {
              "title": @question.title
          }}
    else
      render json: {
          "type": "Question",
          "message": "Erro ao atualizar a questão.",
          "data": {
              "title": question.title
          },
          "error_data": {
              "content": question.errors
          }}
    end
  end

  def destroy
    if @question.destroy
      render json: {
          "type": "Question",
          "message": "Questão deletada com sucesso"
      }
    else
      render json: {
          "type": "Question",
          "message": "Erro ao deletar a questão.",
          "data": {
              "title": @question.title
          },
          "error_data": {
              "content": @question.errors
          }
      }
    end
  end

  private

  def question_params
    params.permit(:title, :content, :correct_answer, :precision, :exercise_id)
  end

  def find_question
    @question = Question.find(params[:id])
    @question.errors.add(:title, "não pode ser nulo")
    @question.errors.add(:content, "não pode ser nulo")
    @question.errors.add(:correct_answer, "não pode ser nulo")
  end

  def find_exercise
    @exercise = Exercise.find(params[:exercise_id])
  end
end
