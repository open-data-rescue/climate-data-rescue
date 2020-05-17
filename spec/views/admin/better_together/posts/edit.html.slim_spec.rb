require 'rails_helper'

RSpec.describe "admin/better_together/posts/edit", type: :view do
  before(:each) do
    @better_together_post = assign(:better_together_post, create(:better_together_post))
  end

  it "renders the edit better_together_post form" do
    render

    assert_select "form[action=?][method=?]", admin_better_together_post_path(@better_together_post), "post" do

      assert_select "input[name=?]", "better_together_post[title]"
      assert_select "textarea[name=?]", "better_together_post[content]"
      assert_select "input[name=?]", "better_together_post[slug]"
    end
  end
end
