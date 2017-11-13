require 'rails_helper'

feature 'user visits users profiles' do
  scenario 'and visits his own' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu perfil'

    expect(page).to have_css('h1', text: "Perfil de #{user.name}")
  end

  scenario 'from recipe' do
    recipe = create(:recipe)

    visit root_path
    click_on recipe.title
    click_on recipe.user.name

    expect(page).to have_css('h1', text: "Perfil de #{recipe.user.name}")
  end

  scenario 'and sees his recipes' do
    recipe_owner = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipes = []
    5.times do
      recipes << create(:recipe, recipe_type: recipe_type, cuisine: cuisine,
                                 user: recipe_owner)
    end

    visit user_profile_path recipe_owner

    within 'section#own-recipes' do
      expect(page).to have_css('h4', text: recipes[0].title)
      expect(page).to have_css('h4', text: recipes[1].title)
      expect(page).to have_css('h4', text: recipes[2].title)
      expect(page).to have_css('h4', text: recipes[3].title)
      expect(page).to have_css('h4', text: recipes[4].title)
    end
  end

  scenario 'and sees his favorite recipes' do
    user = create(:user, name: 'Chistian')
    another_user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipes = []
    5.times do
      recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine,
                               user: user)
      another_user.favorites.create(recipe: recipe)
      recipes << recipe
    end

    visit user_profile_path another_user

    within 'section#favorite-recipes' do
      expect(page).to have_css('h4', text: recipes[0].title)
      expect(page).to have_css('h4', text: recipes[1].title)
      expect(page).to have_css('h4', text: recipes[2].title)
      expect(page).to have_css('h4', text: recipes[3].title)
      expect(page).to have_css('h4', text: recipes[4].title)
    end
  end
end
