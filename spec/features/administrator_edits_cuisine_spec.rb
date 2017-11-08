require 'rails_helper'

feature 'Administrator edits cuisine' do
  scenario 'successfully' do
    cuisine = create(:cuisine, name: 'Brasileira')

    visit root_path
    click_on cuisine.name
    click_on 'Editar cozinha'

    fill_in 'Nome', with: 'Mexicana'
    click_on 'Atualizar Cozinha'

    expect(page).to have_css('h1', text: 'Mexicana')
  end

  scenario 'and don\'t fill required fields' do
    cuisine = create(:cuisine, name: 'Brasileira')

    visit root_path
    click_on cuisine.name
    click_on 'Editar cozinha'

    fill_in 'Nome', with: ''
    click_on 'Atualizar Cozinha'

    expect(page).to have_css('div.alert.alert-danger',
                             text: 'Nome não pode ficar em branco')
  end

  scenario 'and cannot have duplicates' do
    cuisine = create(:cuisine, name: 'Brasileira')
    create(:cuisine, name: 'Mexicana')

    visit root_path
    click_on cuisine.name
    click_on 'Editar cozinha'

    fill_in 'Nome', with: 'Mexicana'
    click_on 'Atualizar Cozinha'

    expect(page).to have_css('div.alert.alert-danger',
                             text: 'Nome já está em uso')
  end
end
