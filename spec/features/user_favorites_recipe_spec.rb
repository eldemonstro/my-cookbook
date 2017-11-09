require 'rails_helper'

feature 'user favorites recipe' do
  scenario 'sucessfully' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Favoritar'

    expect(page).to have_css('.alert.alert-info',
                             text: 'Receita favoritada com sucesso')
  end

  scenario 'and can see his favorited recipes' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Favoritar'
    click_on 'Minhas receitas favoritas'

    expect(page).to have_css('h1', text: 'Minhas receitas favoritas')
    expect(page).to have_css('h2', text: recipe.title)
  end

  scenario 'and favorites lots of recipes' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipes = []
    5.times do
      recipes << create(:recipe, recipe_type: recipe_type, cuisine: cuisine)
    end

    login_as(user, scope: :user)
    recipes.each do |recipe|
      visit recipe_path recipe
      click_on 'Favoritar'
    end
    click_on 'Minhas receitas favoritas'

    expect(page).to have_css('h2', text: recipes[0].title)
    expect(page).to have_css('h2', text: recipes[1].title)
    expect(page).to have_css('h2', text: recipes[2].title)
    expect(page).to have_css('h2', text: recipes[3].title)
    expect(page).to have_css('h2', text: recipes[4].title)
  end

  scenario 'and must be logged in' do
    recipe = create(:recipe)

    visit recipe_path recipe

    expect(page).not_to have_link('Favoritar',
                                  href: favorite_recipe_path(recipe))
  end

  scenario 'and can\'t favorite if owns the recipe' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as(user, scope: :user)
    visit recipe_path recipe

    expect(page).not_to have_link('Favoritar',
                                  href: favorite_recipe_path(recipe))
  end
end
