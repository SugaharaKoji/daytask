FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'testuser@example.com' }
    password { 'password' }
  end
end
