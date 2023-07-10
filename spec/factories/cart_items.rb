FactoryBot.define do
  factory :cart_item do
    shopping_cart { nil }
    product { nil }
    total { "9.99" }
    cancel_cause { "MyString" }
  end
end
