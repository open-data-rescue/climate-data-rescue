require "rails_helper"

RSpec.describe BetterTogether::PostsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/posts").to route_to("better_together/posts#index")
    end

    it "routes to #show" do
      expect(:get => "/posts/1").to route_to("better_together/posts#show", :id => "1")
    end

    it "does not route to #new" do
      expect(:get => "/posts/new").not_to route_to("better_together/posts#new")
    end


    it "does not route to #edit" do
      expect(:get => "/posts/1/edit").not_to route_to("better_together/posts#edit", :id => "1")
    end


    it "does not route to #create" do
      expect(:post => "/posts").not_to route_to("better_together/posts#create")
    end

    it "does not route to #update via PUT" do
      expect(:put => "/posts/1").not_to route_to("better_together/posts#update", :id => "1")
    end

    it "does not route to #update via PATCH" do
      expect(:patch => "/posts/1").not_to route_to("better_together/posts#update", :id => "1")
    end

    it "does not route to #destroy" do
      expect(:delete => "/posts/1").not_to route_to("better_together/posts#destroy", :id => "1")
    end
  end
end
