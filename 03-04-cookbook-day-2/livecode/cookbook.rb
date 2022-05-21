require 'csv'
require_relative 'recipe'


class Cookbook
  def initialize(csv_file)
    # CSV file is being passed in the the app.rb file
    # We initialize the cookbook with csv to persist our data
    @csv_file = csv_file
    @recipes = [] # Will use this to store recipes when we add them
    load_csv # Call the load_csv when we launch our app
    # Reads what we have in the cvs file and populate the @recipes array
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    # should store the new recipe in CSV
    save_csv
  end

  def remove_at(index)
    @recipes.delete_at(index)
    # should remove the new recipe in CSV
    save_csv
  end

  private

  def load_csv
    # Iterate on each row of the csv and for each row do something
    CSV.foreach(@csv_file) do |row|
      # Build recipe instance
      recipe = Recipe.new(row[0], row[1])
      # Push them into the cookbook recipes array
      @recipes << recipe
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv_row|
      # To store recipes, we loop over cookbook recipes array
      # One recipe, one row
      @recipes.each do |recipe|
        # CSV SHOULD NOT TAKE INSTANCES
        # We must individually separate the name and description from the instances
        # Then store them in array format into each row of the CSV
        csv_row << [recipe.name, recipe.description]
      end
    end
  end
end
