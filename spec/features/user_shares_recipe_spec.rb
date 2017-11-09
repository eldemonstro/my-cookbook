require 'rails_helper'

feature 'user shares recipe via email' do
  scenario 'sucessfully' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    within 'section.share' do
      fill_in 'Email', with: 'examplereceive@example.com'
      fill_in 'Nome', with: 'Receiver'
    end

    expect(RecipeMailer).to receive(:share_recipe)
    click_on 'Compartilhar'
  end

  scenario 'and must be logged in' do
    recipe = create(:recipe)

    visit recipe_path recipe

    within 'section.share' do
      expect(page).not_to have_css('form')
      expect(page).to have_css('p', text: "Faça o log in para compartilhar uma \
receita")
    end
  end
end
