require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # 1. Get recipes from cookbook
    recipes = @cookbook.all
    # 2. Send to view to display
    @view.display(recipes)
  end

  def create
    # 1. Ask user for recipe info (name and description)(view)
    recipe_data = @view.ask_for_recipe
    # 2. Create recipe (model)
    # 0 index corresponds to name
    # 1 index corresponds to description
    recipe = Recipe.new(recipe_data[0], recipe_data[1])
    # 3. Store in cookbook (repo)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # 1. Display recipes
    list
    # 2. Ask user for a number (view)
    index = @view.which_to_destroy
    # 3. Remove it from DB (repo)
    @cookbook.remove_at(index)
  end
end
