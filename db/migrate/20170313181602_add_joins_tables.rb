class AddJoinsTables < ActiveRecord::Migration
  def change
    create_join_table :tags, :los
    create_join_table :tags, :introductions
    create_join_table :tags, :exercises
  end
end
