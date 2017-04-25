require 'rails_helper'

RSpec.describe "Api::Subscriptions", type: :request do
  describe "GET /api_subscriptions" do
    it "works! (now write some real specs)" do
      get api_subscriptions_path
      expect(response).to have_http_status(200)
    end
  end
end
