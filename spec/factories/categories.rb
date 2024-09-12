FactoryBot.define do
  factory :category do
    icon { 'mustache' }
    name { "Categoría #{Category.count + 1}" }
  end

  factory :category_without_icon, parent: :category do
    icon { nil }
  end

  factory :category_without_name, parent: :category do
    name { nil }
  end
end
