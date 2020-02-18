require 'rails_helper'

RSpec.describe "admin/better_together/posts/index", type: :view do
  before(:each) do
    assign(:better_together_posts, [
      BetterTogether::Post.create!(
        :bt_id => "Bt"
      ),
      BetterTogether::Post.create!(
        :bt_id => "Bt"
      )
    ])
  end

  it "renders a list of better_together/posts" do
    render
    assert_select "tr>td", :text => "Bt".to_s, :count => 2
  end
end
