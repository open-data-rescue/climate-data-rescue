require 'rails_helper'

RSpec.describe "admin/better_together/posts/index", type: :view do
  before(:each) do
    create_list(:better_together_post, 2)
  end

  # it "renders a list of better_together/posts" do
  #   render
  #   assert_select "tr>td", :text => "Bt".to_s, :count => 2
  # end
end
