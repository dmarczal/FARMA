class AddAdminResearchCategoryRefToAdminResearch < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_researches, :research_category_id, :integer

  end
end
