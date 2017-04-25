require 'rails_helper'

RSpec.describe PublicController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #splash" do
    it "returns http success" do
      get :splash
      expect(response).to have_http_status(:success)
    end
  end

end
