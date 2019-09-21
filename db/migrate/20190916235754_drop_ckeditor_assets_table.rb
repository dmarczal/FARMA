class DropCkeditorAssetsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :ckeditor_assets
  end
end
