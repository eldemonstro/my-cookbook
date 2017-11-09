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

    expect(current_path).to eq recipe_path recipe
  end
end
