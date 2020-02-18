require 'rails_helper'

RSpec.describe "better_together/posts/show", type: :view do
  before(:each) do
    @better_together_post = assign(:better_together_post, BetterTogether::Post.create!(
      :bt_id => "Bt",
      title: 'My First Post',
      content: 'My First Content'
    ))
  end

  it "renders its title" do
    render
    expect(rendered).to match(/My First Post/)
  end
end
