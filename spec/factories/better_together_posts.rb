FactoryBot.define do
  factory :better_together_post, class: 'BetterTogether::Post' do
    bt_id { "MyString" }
    title { 'My title'}
    content { 'My content'}
  end
end
