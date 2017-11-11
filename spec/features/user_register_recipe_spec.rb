require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    user = create(:user, email: 'example@example.com', password: '123456789')
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')
    create(:recipe_type, name: 'Prato Principal')
    create(:recipe_type, name: 'Sobremesa')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: "Trigo para quibe, cebola, tomate picado, \
azeite, salsinha"
    fill_in 'Como Preparar', with: "Misturar tudo e servir. Adicione \
limão a gosto."
    click_on 'Criar Receita'

    recipe = Recipe.last

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: "Trigo para quibe, cebola, tomate \
picado, azeite, salsinha")
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  "Misturar tudo e servir. Adicione \
limão a gosto.")
    expect(page).not_to have_xpath("//img[contains(@src,'star')]")
    expect(recipe.user).to eq user
  end

  scenario 'and must fill in all fields' do
    user = create(:user, email: 'example@example.com', password: '123456789')
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    uncheck 'Destaque'
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Criar Receita'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'and marks as featured' do
    user = create(:user, email: 'example@example.com', password: '123456789')
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')
    create(:recipe_type, name: 'Sobremesa')
    create(:recipe_type, name: 'Prato Principal')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    check 'Destaque'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: "Trigo para quibe, cebola, tomate picado, \
azeite, salsinha"
    fill_in 'Como Preparar', with: "Misturar tudo e servir. Adicione limão a \
gosto."
    click_on 'Criar Receita'

    expect(page).to have_xpath("//img[contains(@src,'star')]")
  end

  scenario 'and must be logged in' do
    visit root_path

    expect(page).not_to have_link('Enviar uma receita', href: new_recipe_path)
  end

  scenario 'and can\'t force if not logged in' do
    visit new_recipe_path

    expect(current_path).to eq new_user_session_path
  end
end
