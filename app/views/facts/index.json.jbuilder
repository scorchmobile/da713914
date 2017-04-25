json.array!(@facts) do |fact|
  json.extract! fact, :id, :headline, :line_one, :line_two
  json.url fact_url(fact, format: :json)
end
