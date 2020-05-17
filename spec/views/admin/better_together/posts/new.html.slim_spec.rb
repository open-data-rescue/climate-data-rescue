require 'rails_helper'

RSpec.describe "admin/better_together/posts/new", type: :view do
  before(:each) do
    assign(:better_together_post, create(:better_together_post))
  end

  # it "renders new better_together_post form" do
  #   render

  #   assert_select "form[action=?][method=?]", admin_better_together_posts_path, "post" do

  #     assert_select "input[name=?]", "better_together_post[title]"
  #     assert_select "textarea[name=?]", "better_together_post[content]"
  #     assert_select "input[name=?]", "better_together_post[slug]"
  #   end
  # end
end
