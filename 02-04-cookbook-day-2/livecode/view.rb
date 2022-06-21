class View
  def display(recipes)
    # Iterate over all recipes
    recipes.each_with_index do |recipe, index|
      # Puts a line for each one
      puts "#{index + 1}. #{recipe.name} - #{recipe.description} : #{recipe.rating}, Prep: #{recipe.prep_time}"
    end
  end

  def ask_for_recipe
    puts "What is the name of your recipe"
    name = gets.chomp

    puts "What is the description of your recipe"
    description = gets.chomp

    puts "What is the rating of your recipe"
    rating = gets.chomp.to_i

    puts "What is the prep time of your recipe"
    prep_time = gets.chomp.to_i

     # Returned as array, so that we can return 2 things at the same time!
    return [name, description, rating, prep_time]
  end

  def which_to_destroy
    puts "Which number do you want to delete?"
    # As indexes have been displayed with + 1 for user experience sake (see display method above)
    # We want to make sure that we then do - 1
    gets.chomp.to_i - 1
  end

  def ask_for(info)
    puts "Please input the #{info}:"
    print ">"
    gets.chomp
  end
end
