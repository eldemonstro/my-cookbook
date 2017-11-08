require 'rails_helper'

feature 'user favorites recipe' do
  scenario 'sucessfully' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Favoritar'

    expect(page).to have_css('.alert.alert-info',
                             text: 'Receita favoritada com sucesso')
  end

  scenario 'and can see his favorited recipes' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Favoritar'
    click_on 'Minhas receitas favoritas'

    expect(page).to have_css('h1', text: 'Minhas receitas favoritas')
    expect(page).to have_css('h2', text: recipe.title)
  end
end
