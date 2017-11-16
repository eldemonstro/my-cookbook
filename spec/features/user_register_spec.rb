require 'rails_helper'

feature 'user register' do
  scenario 'successfully' do
    visit root_path
    within 'nav' do
      click_on 'Cadastrar no site'
    end

    fill_in 'Email', with: 'example@example.com'
    fill_in 'Nome', with: 'Exemplo de Pessoa'
    fill_in 'Senha', with: '123456789'
    fill_in 'Confirmar senha', with: '123456789'
    save_page
    within '.form-actions' do
      click_on 'Cadastrar perfil'
    end

    expect(page).to have_css('div.alert.alert-info',
                             text: 'Bem-vindo! Você se registrou com êxito.')
  end

  scenario 'and must fill all fields' do
    visit root_path
    within 'nav' do
      click_on 'Cadastrar no site'
    end

    fill_in 'Email', with: ''
    fill_in 'Nome', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''
    within '.form-actions' do
      click_on 'Cadastrar perfil'
    end

    expect(page).to have_content('não pode ficar em branco')
  end
end
