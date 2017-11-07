require 'rails_helper'

feature 'Visitor view recipes by type' do
  scenario 'from home page' do
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, recipe_type: recipe_type)

    # simula a acao do usuario
    visit root_path
    click_on 'Sobremesa'

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: recipe_type.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only recipes from same type' do
    # cria os dados necessarios previamente
    dessert_recipe = create(:recipe, title: 'Bolo de cenoura')

    italian_cuisine = create(:cuisine, name: 'Italiana')
    main_recipe_type = create(:recipe_type, name: 'Prato Principal')
    main_recipe = create(:recipe, title: 'Macarrão Carbonara',
                                  recipe_type: main_recipe_type,
                                  cuisine: italian_cuisine,
                                  difficulty: 'Difícil',
                                  cook_time: 30, ingredients: 'Massa, ovos',
                                  method: "Frite o bacon; Cozinhe a massa ate \
ficar al dent; Misture os ovos e o bacon a massa ainda quente;")

    # simula a acao do usuario
    visit root_path
    click_on main_recipe_type.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: main_recipe.title)
    expect(page).to have_css('li', text: main_recipe.recipe_type.name)
    expect(page).to have_css('li', text: main_recipe.cuisine.name)
    expect(page).to have_css('li', text: main_recipe.difficulty)
    expect(page).to have_css('li', text: "#{main_recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: dessert_recipe.title)
    expect(page).not_to have_css('li', text: dessert_recipe.recipe_type.name)
    expect(page).not_to have_css('li', text: dessert_recipe.cuisine.name)
    expect(page).not_to have_css('li', text: dessert_recipe.difficulty)
    expect(page).not_to have_css('li', text: "#{dessert_recipe.cook_time} \
minutos")
  end

  scenario 'and type has no recipe' do
    # cria os dados necessarios previamente
    brazilian_cuisine = create(:cuisine, name: 'Brasileira')
    dessert_recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura',
                             recipe_type: dessert_recipe_type,
                             cuisine: brazilian_cuisine)

    main_dish_type = create(:recipe_type, name: 'Prato Principal')
    # simula a acao do usuario
    visit root_path
    click_on main_dish_type.name

    # expectativas do usuario apos a acao
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content("Nenhuma receita encontrada para este tipo \
de receitas")
  end
end
