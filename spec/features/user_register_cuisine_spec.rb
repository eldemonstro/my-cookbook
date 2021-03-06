require 'rails_helper'

feature 'User register cuisine' do
  scenario 'successfully' do
    visit root_path
    click_on 'Criar nova cozinha'

    fill_in 'Nome', with: 'Brasileira'
    click_on 'Criar Cozinha'

    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content("Nenhuma receita encontrada para este tipo \
de cozinha")
  end

  scenario 'and must fill in name' do
    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Criar Cozinha'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and cannot be duplicate' do
    create(:cuisine, name: 'Brasileira')

    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Criar Cozinha'

    expect(page).to have_content('Nome já está em uso')
  end
end
