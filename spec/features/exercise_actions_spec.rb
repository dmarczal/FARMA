require 'rails_helper'

describe "exercise methods" do
  include FormHelpers
  include ActionView::Helpers::TextHelper

  before :each do
    @user = FactoryGirl.create(:user_actived)
    sing_in @user
    @lo = FactoryGirl.create(:lo, user: @user)
  end

  describe 'method GET' do
    it 'show exercise' do
      exercise = FactoryGirl.create(:exercise, lo: @lo)

      visit(teacher_lo_exercise_path(@lo, exercise))
      expect(page).to have_content truncate("Questões do exercicio #{exercise.title}", length: 25)
    end

    it 'new exercise' do
      visit(new_teacher_lo_exercise_path(@lo))
      expect(page).to have_content 'Novo exercicio'
    end

    it 'edit exercise' do
      exercise = FactoryGirl.create(:exercise, lo: @lo)

      visit(edit_teacher_lo_exercise_path(@lo, exercise))
      expect(page).to have_content truncate("Editar o #{exercise.title}", length: 25)
    end
  end

  describe 'method POST' do
    it 'should add one new exercise' do
      visit(new_teacher_lo_exercise_path(@lo))
      filds = {'exercise_title' => 'test','exercise_content' => 'test'}

      expect{
        fill_in_form filds, ".simple_form"
      }.to change(Exercise,:count).by 1
    end

    it 'should not add one new exercise' do
      visit(new_teacher_lo_exercise_path(@lo))
      filds = {'exercise_title' => nil,'exercise_content' => 'test'}

      expect{
        fill_in_form filds, ".simple_form"
      }.to_not change(Exercise,:count)
    end
  end

  describe 'method PUT' do
    before :each do
      @exercise = FactoryGirl.create(:exercise, lo: @lo)
      visit(edit_teacher_lo_exercise_path(@lo, @exercise))
    end

    it 'should update the exercise' do
      filds = {'exercise_title' => 'test','exercise_content' => 'test'}

      fill_in_form filds, '.simple_form'
      @exercise.reload

      expect(@exercise.title).to eq 'test'
      expect(@exercise.content).to eq 'test'
    end

    it 'should not update one new exercise' do
      filds = {'exercise_title' => nil,'exercise_content' => 'test'}

      fill_in_form filds, '.simple_form'
      @exercise.reload

      expect(@exercise.title).to_not eq nil
      expect(@exercise.content).to_not eq 'test'
    end
  end

  it 'method Delete' do
    exercise = FactoryGirl.create(:exercise, lo: @lo)

    page.driver.submit :delete, teacher_lo_exercise_path(@lo, exercise), {}
    expect(Exercise.exists?(exercise.id)).to eq false
  end
end
