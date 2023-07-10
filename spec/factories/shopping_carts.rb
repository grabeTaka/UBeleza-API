FactoryBot.define do
  factory :shopping_cart do
    establishment { nil }
    table { nil }
    user { nil }
    status { 1 }
    total { "9.99" }
    cause { "MyString" }
  end
end
