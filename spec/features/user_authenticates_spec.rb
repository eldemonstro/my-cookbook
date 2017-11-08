require 'rails_helper'

feature 'user authenticates' do
  scenario 'successfully' do
    create(:user, email: 'example@example.com', password: '123456789')

    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Senha', with: '123456789'
    within '.form-actions' do
      click_on 'Entrar'
    end

    expect(page).to have_css('div.alert.alert-info',
                             text: 'Logado com sucesso.')
    expect(page).not_to have_link('Entrar', href: new_user_session_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
  end

  scenario 'and fill in wrong info' do
    create(:user, email: 'example@example.com', password: '123456789')

    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    fill_in 'Email', with: 'google@gmail.com'
    fill_in 'Senha', with: 'abcdefghij'
    within '.form-actions' do
      click_on 'Entrar'
    end

    expect(page).to have_css('div.alert.alert-danger',
                             text: 'Email ou senha inválida.')
  end

  scenario 'and signs out' do
    user = create(:user, email: 'example@example.com', password: '123456789')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Sair'

    expect(page).to have_css('div.alert.alert-info',
                             text: 'Saiu com sucesso.')
  end
end
