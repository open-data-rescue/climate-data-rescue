require "rails_helper"

RSpec.describe Admin::BetterTogether::PostsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/posts").to route_to("admin/better_together/posts#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/posts/new").to route_to("admin/better_together/posts#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/posts/1").to route_to("admin/better_together/posts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/posts/1/edit").to route_to("admin/better_together/posts#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/admin/posts").to route_to("admin/better_together/posts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/posts/1").to route_to("admin/better_together/posts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/posts/1").to route_to("admin/better_together/posts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/posts/1").to route_to("admin/better_together/posts#destroy", :id => "1")
    end
  end
end
