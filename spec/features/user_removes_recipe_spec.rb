require 'rails_helper'

feature 'User removes a recipe' do
  scenario 'successfully' do
    recipe = create(:recipe)

    visit root_path
    click_on recipe.title
    click_on 'Excluir'

    expect(Recipe.count).to eq 0
    expect(page).to have_content('Excluido com sucesso')
  end
end
