require 'rails_helper'

feature 'administrator edits recipe type' do
  scenario 'successfully' do
    recipe_type = create(:recipe_type, name: 'Entrada')

    visit root_path
    click_on recipe_type.name
    click_on 'Editar tipo de receita'

    fill_in 'Nome', with: 'Jantar'
    click_on 'Atualizar Tipo de Receita'

    expect(page).to have_css('h1', text: 'Jantar')
  end

  scenario 'and don\'t fill required fields' do
    recipe_type = create(:recipe_type, name: 'Entrada')

    visit root_path
    click_on recipe_type.name
    click_on 'Editar tipo de receita'

    fill_in 'Nome', with: ''
    click_on 'Atualizar Tipo de Receita'

    expect(page).to have_css('div.alert.alert-danger',
                             text: 'Nome não pode ficar em branco')
  end

  scenario 'and cannot have duplicates' do
    recipe_type = create(:recipe_type, name: 'Entrada')
    create(:recipe_type, name: 'Jantar')

    visit root_path
    click_on recipe_type.name
    click_on 'Editar tipo de receita'

    fill_in 'Nome', with: 'Jantar'
    click_on 'Atualizar Tipo de Receita'

    expect(page).to have_css('div.alert.alert-danger',
                             text: 'Nome já está em uso')
  end
end
