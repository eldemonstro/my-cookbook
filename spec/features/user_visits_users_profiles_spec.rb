require 'rails_helper'

feature 'user visits users profiles' do
  scenario 'and visits his own' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu perfil'

    expect(page).to have_css('h1', text: 'Seu perfil')
    expect(page).to have_css('h2', text: user.name)
  end
end
