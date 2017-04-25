json.array!(@api_payments) do |api_payment|
  json.extract! api_payment, :id
  json.url api_payment_url(api_payment, format: :json)
end
