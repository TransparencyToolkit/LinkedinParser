# coding: utf-8
load 'utilities.rb'

class RelatedPeople
  include Utilities
  def initialize(html)
    @html = html
    parse_related
  end

  # Get list of groups
  def get_related
    return @related_people_list
  end

  def parse_related
    related_people = @html.css(".insights").css(".browse-map").css(".profile-card")

    @related_people_list = Array.new
    related_people.each do |person|
      @related_people_list.push({
                                  related_name: related_name(person),
                                  related_link: related_link(person),
                                  related_person_company: related_person_company(person),
                                  related_person_title: related_person_title(person)
                                })
    end
  end

  # Get name of related person
  def related_name(person)
    return person.css("h4").text
  end

  # Get link to related person's profile
  def related_link(person)
    return person.css("h4").css("a")[0]["href"]
  end

  # Get related person's company
  def related_person_company(person)
    return person.css(".headline").text.split(" at ")[1]
  end

  # Get title of related person
  def related_person_title(person)
    return person.css(".headline").text.split(" at ")[0]
  end
end
