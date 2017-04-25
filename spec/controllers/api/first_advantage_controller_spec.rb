require 'rails_helper'

RSpec.describe Api::FirstAdvantageController, type: :controller do

  describe "GET #candidate_invitation" do
    it "returns http success" do
      get :candidate_invitation
      expect(response).to have_http_status(:success)
    end
  end

end
