Fabricator :user do
  firstname { sequence(:firstname) {|i| "firstname #{i}" }}
  lastname { sequence(:lastname) {|i| "lastname #{i}" }}
  email { sequence(:email) {|i| "foo#{i}@bar.com" }}
  password "password"
end
