require 'rails_helper'

feature 'user updates profile' do
  scenario 'sucessfully' do
    user = create(:user, name: 'Christian', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu perfil'
    click_on 'Atualizar meu perfil'

    fill_in 'Nome', with: 'Ronaldo'
    fill_in 'Cidade', with: 'São Paulo - SP'
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Senha', with: '456123'
    fill_in 'Confirmar senha', with: '456123'
    fill_in 'Senha atual', with: '123456'
    click_on 'Atualizar perfil'

    expect(page).to have_css('.alert.alert-info',
                             text: 'Sua conta foi atualizada com sucesso.')
  end
end
