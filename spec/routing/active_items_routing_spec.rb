require "rails_helper"

RSpec.describe ActiveItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/active_items").to route_to("active_items#index")
    end

    it "routes to #new" do
      expect(:get => "/active_items/new").to route_to("active_items#new")
    end

    it "routes to #show" do
      expect(:get => "/active_items/1").to route_to("active_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/active_items/1/edit").to route_to("active_items#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/active_items").to route_to("active_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/active_items/1").to route_to("active_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/active_items/1").to route_to("active_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/active_items/1").to route_to("active_items#destroy", :id => "1")
    end
  end
end
