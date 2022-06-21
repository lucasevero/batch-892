class Recipe
  attr_reader :name, :description, :rating
  attr_accessor :prep_time

  def initialize(name, description, rating, prep_time)
    # Store information in instance variables
    @name = name
    @description = description
    @rating = rating
    @prep_time = prep_time
  end
end
