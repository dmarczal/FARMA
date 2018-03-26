class Admin::Research < ApplicationRecord
    validates :title, :ref, :abstract, :link, :kind, presence: true
end

#create_table "admin_researches", id: :serial, force: :cascade do |t|
#  t.string "title"
#  t.text "ref"
#  t.text "abstract"
#  t.string "link"
#  t.string "kind"
#  t.datetime "created_at", null: false
#  t.datetime "updated_at", null: false
#end
