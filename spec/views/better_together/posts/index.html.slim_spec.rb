require 'rails_helper'

RSpec.describe "better_together/posts/index", type: :view do
  before(:each) do
    assign(:better_together_posts, [
      BetterTogether::Post.create!(
        title: 'My First Post',
        content: 'My Seocnd Content'
      ),
      BetterTogether::Post.create!(
        title: 'My First Post',
        content: 'My Seocnd Content'
      )
    ])
  end

  it "renders a list of better_together/posts" do
    render
    assert_select "h3.post-title", :count => 2
  end
end
