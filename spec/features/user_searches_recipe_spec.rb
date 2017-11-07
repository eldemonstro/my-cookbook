require 'rails_helper'

feature 'User searches a recipe' do
  scenario 'successfully' do
    create(:recipe)

    visit root_path
    fill_in 'pesquisar', with: 'Bolo de cenoura'
    find('input[name="commit"]').click

    expect(page).to have_content('Bolo de cenoura')
  end

  scenario 'and finds nothing' do
    visit root_path
    fill_in 'pesquisar', with: 'Bolo de cenoura'
    find('input[name="commit"]').click

    expect(page).to have_content('Nenhuma receita encontrada')
  end

  scenario 'and finds various recipes' do
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    create(:recipe, recipe_type: recipe_type, cuisine: cuisine)

    create(:recipe, title: 'Bolo de chocolate', recipe_type: recipe_type,
                    cuisine: cuisine)

    visit root_path
    fill_in 'pesquisar', with: 'Bolo'
    find('input[name="commit"]').click

    expect(page).to have_content('Bolo de cenoura')
    expect(page).to have_content('Bolo de chocolate')
  end
end
