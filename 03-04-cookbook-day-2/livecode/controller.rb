require_relative 'view'
require_relative 'scrape_all_recipes_service'

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
    recipe = Recipe.new(recipe_data[0], recipe_data[1], recipe_data[2], recipe_data[3])
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

  def import
    # 1. ask for the ingredient of the recipe
    ingredient = @view.ask_for("the ingredient you are looking for")
    # 2. get the HTMl file for this ingredient
    # 3. look for the info nedded
    # 4. create a recipe with the info
    scrape = ScrapeAllRecipesService.new(ingredient)
    recipes = scrape.call
    links = scrape.get_links
    # 5. display the recipes and ask for index
    @view.display(recipes)
    index = @view.ask_for("the index of the recipe").to_i - 1
    # 6. add the recipe chosen to the cookbook
    recipe = recipes[index]

    link = links[index]
    prep_time = scrape.get_prep_time(link)

    recipe.prep_time = prep_time
    @cookbook.add_recipe(recipe)
  end
end
