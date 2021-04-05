# This will guess the User class
FactoryBot.define do
  factory :movie do
    title { "Foo" }
    year  { 1991 }
    runtime { 99 }
    director { "Bob" }
    plot { "In a galaxy kinda far away..."}
  end
end