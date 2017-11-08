require 'rails_helper'

feature 'User removes a recipe' do
  scenario 'successfully' do
    user = create(:user, email: 'example@example.com', password: '123456789')
    recipe = create(:recipe, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Excluir'

    expect(Recipe.count).to eq 0
    expect(page).to have_content('Excluido com sucesso')
  end

  scenario 'and must be logged in' do
    recipe = create(:recipe)

    visit root_path
    click_on recipe.title

    expect(page).not_to have_link('Excluir')
  end

  scenario 'and must own the recipe' do
    user = create(:user, email: 'example@example.com', password: '123456789')
    another_user = create(:user)
    recipe = create(:recipe, user: another_user)

    login_as(user, scope: :user)
    visit recipe_path recipe

    expect(page).not_to have_link('Excluir')
  end

  scenario 'and cannot force if not logged in' do
    recipe = create(:recipe)

    page.driver.submit :delete, recipe_path(recipe), {}

    expect(current_path).to eq new_user_session_path
  end
end
