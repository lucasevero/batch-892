require 'open-uri'
require 'nokogiri'
require_relative 'recipe'

ingredient = "strawberry"
url = "https://www.allrecipes.com/search/results/?search=#{ingredient}"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

names = []
html_doc.search(".card__title").first(5).each do |title|
  names << title.text.strip
end

descriptions = []
html_doc.search(".card__summary").first(5).each do |description|
  descriptions << description.text.strip
end

recipes = []
names.each_with_index do |name, index|
  recipes << Recipe.new(name, descriptions[index])
end


# CSS SELECTORS
# "." - class
# "#" - id
# "" - tag (h1, p, img)

# <h1 class="title red"
  # <red></red>
# </h1>
# ".title.red"
