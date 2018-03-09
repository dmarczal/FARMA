# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create_with(password: '12345678').find_or_create_by!(email: 'admin@farma.educacional.mat.br')

%w(Artigos Poster TCC Mestrado Doutorado).each do |name|
  Admin::ResearchCategory.find_or_create_by!(name: name)
end

