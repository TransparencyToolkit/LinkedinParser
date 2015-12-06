# coding: utf-8
load 'utilities.rb'

class Languages
  include Utilities
  def initialize(html)
    @html = html
    parse_languages
  end

  # Get list of langauges
  def get_languages
    return @language_list
  end

  def parse_languages
    languages = @html.css("#languages").css("li")

    @language_list = Array.new
    languages.each do |l|
      @language_list.push({
                            language: language(l),
                            proficiency: proficiency(l)
                          })
    end
  end

  # Language name
  def language(language_name)
    language_name.css("h4").text
  end

  # Get proficiency
  def proficiency(language_name)
    language_name.css(".proficiency").text
  end
end
