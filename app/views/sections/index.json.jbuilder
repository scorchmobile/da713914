json.array!(@sections) do |section|
  json.extract! section, :id, :page_id, :title, :content, :visible, :private, :image
  json.url section_url(section, format: :json)
end
