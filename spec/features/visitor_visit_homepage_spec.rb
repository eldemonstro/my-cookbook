require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: "Bem-vindo ao maior livro de receitas \
online")
  end

  scenario 'and view recipe' do
    recipe = create(:recipe)

    visit root_path

    expect(page).to have_css('h4.card-title', text: recipe.title)
    expect(page).to have_css('h6.card-subtitle',
                             text: "Por #{recipe.user.name}")
    expect(page).to have_css('dd', text: recipe.recipe_type.name)
    expect(page).to have_css('dd', text: recipe.cuisine.name)
    expect(page).to have_css('dd', text: recipe.difficulty)
    expect(page).to have_css('dd', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine)

    another_recipe_type = create(:recipe_type, name: 'Prato Principal')
    another_recipe = create(:recipe, title: 'Feijoada',
                                     recipe_type: another_recipe_type,
                                     cuisine: cuisine, difficulty: 'Difícil',
                                     ingredients: 'Feijao, paio, carne seca',
                                     method: "Cozinhar o feijao e refogar com \
as carnes já preparadas",
                                     cook_time: 90)

    visit root_path

    expect(page).to have_css('h4.card-title', text: recipe.title)
    expect(page).to have_css('h6.card-subtitle',
                             text: "Por #{recipe.user.name}")
    expect(page).to have_css('dd', text: recipe.recipe_type.name)
    expect(page).to have_css('dd', text: recipe.cuisine.name)
    expect(page).to have_css('dd', text: recipe.difficulty)
    expect(page).to have_css('dd', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h4.card-title', text: another_recipe.title)
    expect(page).to have_css('h6.card-subtitle',
                             text: "Por #{another_recipe.user.name}")
    expect(page).to have_css('dd', text: another_recipe.recipe_type.name)
    expect(page).to have_css('dd', text: another_recipe.cuisine.name)
    expect(page).to have_css('dd', text: another_recipe.difficulty)
    expect(page).to have_css('dd', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view last six recipes' do
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipes = []
    recipes << create(:recipe, title: 'Bolo', recipe_type: recipe_type,
                               cuisine: cuisine)
    recipes << create(:recipe, title: 'Brigadeiro', recipe_type: recipe_type,
                               cuisine: cuisine)
    recipes << create(:recipe, title: 'Pastel', recipe_type: recipe_type,
                               cuisine: cuisine)
    recipes << create(:recipe, title: 'Sorvete', recipe_type: recipe_type,
                               cuisine: cuisine)
    recipes << create(:recipe, title: 'Esfirra', recipe_type: recipe_type,
                               cuisine: cuisine)
    recipes << create(:recipe, title: 'Coxinha', recipe_type: recipe_type,
                               cuisine: cuisine)
    recipes << create(:recipe, title: 'Risole', recipe_type: recipe_type,
                               cuisine: cuisine)

    visit root_path

    expect(page).not_to have_content(recipes[0].title)
    expect(page).to have_content(recipes[1].title)
    expect(page).to have_content(recipes[2].title)
    expect(page).to have_content(recipes[3].title)
    expect(page).to have_content(recipes[4].title)
    expect(page).to have_content(recipes[5].title)
    expect(page).to have_content(recipes[6].title)
  end
end
