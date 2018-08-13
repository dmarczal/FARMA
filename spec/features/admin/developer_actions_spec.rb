require 'rails_helper'

describe 'Developer features' do

  let(:admin) { create(:admin) }
  let(:breadcrumbs) { page.all('.breadcrumb').map { |breadcrumb| breadcrumb.text } }

  before { sign_in admin }

  describe '#show' do
    let(:developer) { FactoryBot.create(:admin_developer)}

    before { visit(admin_developer_path(developer)) }

    it 'display the correct the deveper\' data' do
        expect(page).to have_content developer.profile_image
        expect(page).to have_content developer.name
        expect(page).to have_content developer.function
        expect(page).to have_content developer.start_on_project
    end

    it 'display breadcrumbs' do
      developer_breadcrumb = "Desenvolvedor " + developer.name
      expect(breadcrumbs).to eql ['Desenvolvedores', "#{truncate(developer_breadcrumb, :length => 25)}"]
    end
  end

  describe '#index' do
    let!(:developers) {create_list(:admin_developer, 5)}

    before { visit(admin_developers_path) }

    it 'display the correct the devepers\' data' do
      developers.each do |developer|
        expect(page).to have_content developer.name
        expect(page).to have_content developer.function
        expect(page).to have_content developer.profile_image
      end
    end

    it 'display breadcrumbs' do
      expect(breadcrumbs).to eq ['Desenvolvedores']
    end
  end

    describe '#create' do
      before { visit(new_admin_developer_path) }

      context 'when all parameters sent are valid and the developer is active' do
          let(:developer) { FactoryBot.create(:admin_developer)}

          let(:params){
            {
            'admin_developer_name' => developer.name,
            'admin_developer_function' => developer.function,
            'admin_developer_institution' => developer.institution,
            'admin_developer_link' => developer.link,
            'admin_developer_start_on_project' => developer.start_on_project
            }
          }


      it 'display the create the correct the devepers\' data' do
        find(:css, "#admin_developer_active").set(true)
        fill_in_form '.simple_form', params
        expect(page.current_path).to eq admin_developer_path(Admin::Developer.last)
      end
      end

      context 'when all parameters sent are valid and the developer is no more active' do
          let(:developer) { FactoryBot.create(:admin_developer, :unactive)}

          let(:params){
            {
            'admin_developer_name' => developer.name,
            'admin_developer_function' => developer.function,
            'admin_developer_institution' => developer.institution,
            'admin_developer_link' => developer.link,
            'admin_developer_start_on_project' => developer.start_on_project,
            'admin_developer_leave_project' => developer.leave_project
            }
          }

      it 'display the create the correct the devepers\' data' do
        find(:css, "#admin_developer_active").set(false)
        fill_in_form '.simple_form', params
        expect(page.current_path).to eq admin_developer_path(Admin::Developer.last)
      end
      end

      context 'when there is invalid or blank parameters' do
          let(:developer) { FactoryBot.create(:admin_developer, :unactive)}

          let(:params){
            {
            'admin_developer_name' => '',
            'admin_developer_function' => developer.function,
            'admin_developer_institution' => developer.institution,
            'admin_developer_link' => developer.link,
            'admin_developer_start_on_project' => developer.start_on_project,
            'admin_developer_leave_project' => developer.leave_project
            }
          }

      it 'display the create the correct the devepers\' data' do
        find(:css, "#admin_developer_active").set(false)
        fill_in_form '.simple_form', params
        expect(page.current_path).to eq admin_developers_path
      end
      end
    end

    describe '#update' do
      let(:developer) { FactoryBot.create(:admin_developer, :unactive)}
      before { visit(edit_admin_developer_path(developer)) }

      context 'when all parameters are valids and the admin is not active' do
          let(:params){
            {
            'admin_developer_name' => 'Jose Irineu',
            'admin_developer_function' => developer.function,
            'admin_developer_institution' => developer.institution,
            'admin_developer_link' => developer.link,
            'admin_developer_start_on_project' => developer.start_on_project,
            'admin_developer_leave_project' => developer.leave_project
            }
          }

      it 'redirect to admin_developers_path the devepers\' data' do
        find(:css, "#admin_developer_active").set(false)
        fill_in_form '.simple_form', params
        expect(page.current_path).to eq admin_developers_path
      end
      end
            context 'when there is invalid or blank parameters' do
                let(:params){
                  {
                  'admin_developer_name' => '',
                  'admin_developer_function' => developer.function,
                  'admin_developer_institution' => developer.institution,
                  'admin_developer_link' => developer.link,
                  'admin_developer_start_on_project' => developer.start_on_project,
                  'admin_developer_leave_project' => developer.leave_project
                  }
                }

            it 'redirect to admin_developers_path the devepers\' data' do
              find(:css, "#admin_developer_active").set(false)
              fill_in_form '.simple_form', params
              expect(page.current_path).to eq admin_developer_path(developer)
            end
            end
    end
end
