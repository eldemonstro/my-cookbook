require 'rails_helper'

feature 'User register recipe_type' do
  scenario 'successfully' do
    visit root_path
    click_on 'Criar novo tipo de receita'

    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Sobremesa')
    expect(page).to have_content("Nenhuma receita encontrada para este tipo de \
receitas")
  end

  scenario 'and must fill in name' do
    visit new_recipe_type_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and cannot be duplicate' do
    RecipeType.create(name: 'Sobremesa')

    visit new_recipe_type_path
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end
end
