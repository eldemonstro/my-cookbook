require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')
    create(:recipe_type, name: 'Prato Principal')
    create(:recipe_type, name: 'Sobremesa')
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
    click_on 'Enviar'

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
  end

  scenario 'and must fill in all fields' do
    create(:cuisine, name: 'Arabe')
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    uncheck 'Destaque'
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and marks as featured' do
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')
    create(:recipe_type, name: 'Sobremesa')
    create(:recipe_type, name: 'Prato Principal')

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
    click_on 'Enviar'

    expect(page).to have_xpath("//img[contains(@src,'star')]")
  end
end
