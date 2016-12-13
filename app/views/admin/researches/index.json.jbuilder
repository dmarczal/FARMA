json.array!(@admin_researches) do |admin_research|
  json.extract! admin_research, :id, :title, :ref, :abstract, :link, :kind
  json.url admin_research_url(admin_research, format: :json)
end
