require "rails_helper"

RSpec.describe Api::SubscriptionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/subscriptions").to route_to("api/subscriptions#index")
    end

    it "routes to #new" do
      expect(:get => "/api/subscriptions/new").to route_to("api/subscriptions#new")
    end

    it "routes to #show" do
      expect(:get => "/api/subscriptions/1").to route_to("api/subscriptions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/subscriptions/1/edit").to route_to("api/subscriptions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/subscriptions").to route_to("api/subscriptions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/subscriptions/1").to route_to("api/subscriptions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/subscriptions/1").to route_to("api/subscriptions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/subscriptions/1").to route_to("api/subscriptions#destroy", :id => "1")
    end

  end
end
