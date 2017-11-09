class RecipeMailer < ApplicationMailer
  def share_recipe(recipe_id, user_id, receiver_name, receiver_email)
    user = User.find(user_id)
    subject = "#{receiver_name} veja essa receita que #{user.name} te mandou"
    @recipe = Recipe.find(recipe_id)
    mail(to: receiver_email, subject: subject)
  end
end
