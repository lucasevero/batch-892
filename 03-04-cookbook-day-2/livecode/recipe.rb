class Recipe
  attr_reader :name, :description

  def initialize(name, description)
    # Store information in instance variables
    @name = name
    @description = description
  end
end
