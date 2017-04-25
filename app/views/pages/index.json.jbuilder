json.array!(@pages) do |page|
  json.extract! page, :id, :title, :visible, :private, :permalink
  json.url page_url(page, format: :json)
end
