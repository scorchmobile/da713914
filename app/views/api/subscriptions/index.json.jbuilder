json.array!(@api_subscriptions) do |api_subscription|
  json.extract! api_subscription, :id
  json.url api_subscription_url(api_subscription, format: :json)
end
