require 'open-uri'
require 'nokogiri'
require_relative 'recipe'

class ScrapeAllRecipesService
  def initialize(ingredient)
    @ingredient = ingredient
    url = "https://www.allrecipes.com/search/results/?search=#{@ingredient}"

    html_file = URI.open(url).read
    @html_doc = Nokogiri::HTML(html_file)
  end

  def call

    names = []
    @html_doc.search(".card__title").first(5).each do |title|
      names << title.text.strip
    end

    descriptions = []
    @html_doc.search(".card__summary").first(5).each do |description|
      descriptions << description.text.strip
    end

    ratings = []
    @html_doc.search(".review-star-text").first(5).each do |rating|
      ratings << rating.text.strip.scan(/(\d)(\.\d)?/).join.to_f
    end

    recipes = []
    names.each_with_index do |name, index|
      recipes << Recipe.new(name, descriptions[index], ratings[index], "pending")
    end

    recipes
  end

  def get_links
    links = []
    @html_doc.search(".card__imageContainer .card__titleLink").first(5).each do |link|
      links << link.attribute("href").value
    end
    links
  end

  def get_prep_time(link)
    html_file = URI.open(link).read
    html_doc = Nokogiri::HTML(html_file)

    prep_time = ""
    html_doc.search(".recipe-meta-item").each do |pair|
      if pair.search(".recipe-meta-item-header")[0].text == "total:"
        prep_time = pair.search(".recipe-meta-item-body")[0].text.strip
      end
    end
    prep_time
  end
end
