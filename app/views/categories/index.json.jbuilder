json.array!(@categories) do |category|
  json.extract! category, :id, :name, :permalink, :description, :image, :visible, :position
  json.url category_url(category, format: :json)
end
