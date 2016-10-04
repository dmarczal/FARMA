require 'rails_helper'

describe "introduction methods" do
  include FormHelpers
  include ActionView::Helpers::TextHelper

  before :each do
    @user = FactoryGirl.create(:user_actived)
    sing_in @user
    @lo = FactoryGirl.create(:lo, user: @user)
  end

  describe 'method GET' do
    it 'new introduction' do
      visit(new_teacher_lo_introduction_path(@lo))
      expect(page).to have_content 'Nova Introdução'
    end

    it 'edit introduction' do
      introduction = FactoryGirl.create(:introduction, lo: @lo)

      visit(edit_teacher_lo_introduction_path(@lo, introduction))
      expect(page).to have_content truncate("Editar Introdução", length: 25)
    end
  end

  describe 'method POST' do
    it 'should add one new introduction' do
      visit(new_teacher_lo_introduction_path(@lo))
      filds = {'introduction_title' => 'test','introduction_content' => 'test'}

      expect{
        fill_in_form filds, ".simple_form"
      }.to change(Introduction,:count).by 1
    end

    it 'should not add one new introduction' do
      visit(new_teacher_lo_introduction_path(@lo))
      filds = {'introduction_title' => nil,'introduction_content' => 'test'}

      expect{
        fill_in_form filds, ".simple_form"
      }.to_not change(Introduction,:count)
    end
  end

  describe 'method PUT' do
    it 'should update the introduction' do
      introduction = FactoryGirl.create(:introduction, lo: @lo)
      visit(edit_teacher_lo_introduction_path(@lo, introduction))
      filds = {'introduction_title' => 'test','introduction_content' => 'test'}

      fill_in_form filds, '.simple_form'
      introduction.reload

      expect(introduction.title).to eq 'test'
      expect(introduction.content).to eq 'test'
    end

    it 'should not update one new introduction' do
      introduction = FactoryGirl.create(:introduction, lo: @lo)
      visit(edit_teacher_lo_introduction_path(@lo, introduction))
      filds = {'introduction_title' => nil,'introduction_content' => 'test'}

      fill_in_form filds, '.simple_form'
      introduction.reload

      expect(introduction.title).to_not eq nil
      expect(introduction.content).to_not eq 'test'
    end
  end

  it 'method Delete' do
    introduction = FactoryGirl.create(:introduction, lo: @lo)

    page.driver.submit :delete, teacher_lo_introduction_path(@lo, introduction), {}
    expect(Introduction.exists?(introduction.id)).to eq false
  end

end
