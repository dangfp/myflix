Fabricator(:category) do
  name { Faker::Name.title }
end

Fabricator(:invalid_category, from: :category) do
  name nil
end