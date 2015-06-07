Fabricator :user do
  email { sequence(:email) {|i| "foo#{i}@bar.com" }}
end
