FactoryBot.define do
  factory :recipe do
    sequence(:title) { |n| "Bolo de cenoura #{n}" }
    difficulty 'Médio'
    ingredients 'Cenoura, acucar, oleo e chocolate'
    add_attribute(:method) { 'Misturar tudo, bater e assar' }
    cook_time '60'
    cuisine
    recipe_type
    user
  end
end
