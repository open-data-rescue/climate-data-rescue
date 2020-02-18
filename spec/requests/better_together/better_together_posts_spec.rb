require 'rails_helper'

RSpec.describe "BetterTogether::Posts", type: :request do
  describe "GET /better_together_posts" do
    it "works! (now write some real specs)" do
      get better_together_posts_path
      expect(response).to have_http_status(200)
    end
  end
end
