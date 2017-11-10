require 'rails_helper'

RSpec.describe 'user deletes recipe', type: :request do
  it 'and must be owner' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user, scope: :user)
    delete recipe_path recipe
    assert_response :redirect
    follow_redirect!

    assert_select 'div.alert-danger', 'Somente o dono da receita pode a excluir'
  end
end
