def create_recipe(title, recipe_type, cuisine)
  Recipe.create(title: title, recipe_type: recipe_type,
                        cuisine: cuisine, difficulty: 'Médio',
                        ingredients: 'Cenoura, acucar, oleo e chocolate',
                        method: 'Misturar tudo, bater e assar',
                        cook_time: 60)

end
