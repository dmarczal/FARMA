class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :image_id
      t.string :image_filename
      t.string :image_content_size
      t.string :profile_image_content_type
      t.integer :subject_id
      t.string :subject_type

      t.timestamps
    end
  end
end
