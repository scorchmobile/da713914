json.array!(@products) do |product|
  json.extract! product, :id, :category_id, :price, :name, :description, :image, :visible, :position, :permalink
  json.url product_url(product, format: :json)
end
