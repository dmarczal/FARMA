require 'rails_helper'

describe "lo methods" do
  include FormHelpers

  before :each do
    @user = FactoryGirl.create(:user_actived)
    sing_in @user
  end

  describe "POST create" do
    before :each do
      visit new_teacher_lo_path
    end

    context 'with valid attributes' do
      before :each do
        @filds = {'lo_name' => 'test','lo_description' => 'test'}
      end

      it "should redirect to teacher_los_path after create the new lo" do
        fill_in_form @filds, ".simple_form"
        expect(page.current_path).to eq teacher_los_path
        expect(page).to have_content 'test'
      end

      it "should add one new lo" do
        expect{
          fill_in_form @filds, ".simple_form"
        }.to change(Lo,:count).by 1
      end
    end

    context 'with invalid attributes' do
      it 'should not add one new lo' do
        @filds = {'lo_name' => nil,'lo_description' => 'test'}

        expect{
          fill_in_form @filds, ".simple_form"
        }.to_not change(Lo,:count)
      end
    end
  end

  describe "PUT update" do
    before :each do
      @lo = FactoryGirl.create(:lo, user: @user)
      visit teacher_los_path
      @filds = {'lo_name' => 'test','lo_description' => 'test-description'}
    end

    context 'whith valid attributes' do
      before :each do
        find("a[href='#{edit_teacher_lo_path(@lo)}']").click
        expect(page.current_path).to eq edit_teacher_lo_path(@lo)
        fill_in_form @filds, '.simple_form'
      end

      it 'should redirect to teacher_los_path after update the lo' do
        expect(page.current_path).to eq teacher_los_path
      end

      it 'should update the attributes the lo' do
        expect(page).to have_content 'test'
        expect(page).to have_content 'test-description'
      end
    end

    context 'whith invalid attributes' do
      before :each do
        @filds = {'lo_name' => nil,'lo_description' => 'test-description'}
        find("a[href='#{edit_teacher_lo_path(@lo)}']").click
        expect(page.current_path).to eq edit_teacher_lo_path(@lo)
        fill_in_form @filds, '.simple_form'
      end

      it 'should render de workspace_lo_path after try update the lo' do
        expect(page.current_path).to eq teacher_lo_path(@lo)
      end

      it 'should not update the attributes the lo' do
        visit teacher_los_path
        expect(page).to have_content @lo.name
        expect(page).to have_content @lo.description
      end
    end
  end
end
