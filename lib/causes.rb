# coding: utf-8
load 'utilities.rb'

class Causes
  include Utilities
  def initialize(html)
    @html = html
    parse_causes
  end

  # Get list of causes
  def get_causes
    return @cause_hash
  end

  def parse_causes
    volunteering = @html.css("#volunteering")
    if !is_empty?(volunteering)
      @cause_hash = Hash.new
      @cause_hash[:volunteer_opportunities] = volunteer_opportunities(volunteering)
      @cause_hash[:supported_causes] = supported_causes(volunteering)
      @cause_hash[:supported_organizations] = supported_organizations(volunteering)
    end
  end

  # Get opportunities they are looking for
  def volunteer_opportunities(volunteering)
    section = volunteering.css(".opportunities").css("li")
    return make_list(section) if !is_empty?(section)
  end

  # Get causes they support
  def supported_causes(volunteering)
    section = get_right_section("Causes", volunteering.css(".extra-section"))
    return make_list(section.css("li")) if !is_empty?(section)
  end

  # Get organizations they support
  def supported_organizations(volunteering)
    section = get_right_section("Organizations", volunteering.css(".extra-section"))
    return make_list(section.css("li")) if !is_empty?(section)
  end

  def get_right_section(look_for, sections)
    sections.each do |section|
      return section if section.css("h4").text.include?(look_for)
    end
    return nil
  end
end
