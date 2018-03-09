class CreateAdminResearchCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_research_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
