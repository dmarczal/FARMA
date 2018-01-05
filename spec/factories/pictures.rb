require "refile/file_double"

FactoryBot.define do
  factory :picture do
    image { Refile::FileDouble.new("dummy", "logo.png", content_type: "image/png") }

    trait :text_file do
      image { Refile::FileDouble.new("dummy", "file.txt", content_type: "text/plain") }
    end
  end
end
