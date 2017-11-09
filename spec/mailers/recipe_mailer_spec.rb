require 'rails_helper'

RSpec.describe RecipeMailer, type: :mailer do
  describe 'shares recipe' do
    it 'renders email sucessfully' do
      user = create(:user)
      recipe = create(:recipe)
      receiver_name = 'José'
      receiver_email = 'jose@josejose.com'

      mail = RecipeMailer.share_recipe(recipe.id, user.id, receiver_name,
                                       receiver_email)

      expect(mail.to).to include receiver_email
      expect(mail.from).to include 'no-reply@mycookbook.com'
      expect(mail.subject).to eq "#{receiver_name} veja essa receita que \
#{user.name} te mandou"
    end

    it 'renders email body sucessfully' do
      user = create(:user)
      recipe = create(:recipe)
      receiver_name = 'José'
      receiver_email = 'jose@josejose.com'

      mail = RecipeMailer.share_recipe(recipe.id, user.id, receiver_name,
                                       receiver_email)

      link = "<a href=\"#{recipe_url(recipe)}\">#{recipe.title}</a>"
      body = "Entre em mycookbook.com e veja a receita de #{link} e \
muitas outras"

      expect(mail.body).to match('Recomendação de receita')
      expect(mail.body).to match body
    end
  end
end
