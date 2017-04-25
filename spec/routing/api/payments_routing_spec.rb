require "rails_helper"

RSpec.describe Api::PaymentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/payments").to route_to("api/payments#index")
    end

    it "routes to #new" do
      expect(:get => "/api/payments/new").to route_to("api/payments#new")
    end

    it "routes to #show" do
      expect(:get => "/api/payments/1").to route_to("api/payments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/payments/1/edit").to route_to("api/payments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/payments").to route_to("api/payments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/payments/1").to route_to("api/payments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/payments/1").to route_to("api/payments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/payments/1").to route_to("api/payments#destroy", :id => "1")
    end

  end
end
