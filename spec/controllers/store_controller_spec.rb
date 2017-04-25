require 'rails_helper'

RSpec.describe StoreController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #category_handler" do
    it "returns http success" do
      get :category_handler
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #product_handler" do
    it "returns http success" do
      get :product_handler
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #search" do
    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end
  end

end
