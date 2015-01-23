Fabricator(:user) do
  email { Faker::Internet.email }
  password { Faker::Internet.password(6, 20) }
  full_name { Faker::Name.name }
end

Fabricator(:invalid_user, from: :user) do
  email nil
end