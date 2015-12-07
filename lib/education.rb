# coding: utf-8
load 'utilities.rb'

class Education
  include Utilities
  def initialize(html)
    @html = html
    parse_education
  end

  # Get list of jobs
  def get_education
    return @degree_list
  end

  def parse_education
    schools = @html.css(".schools").css(".school")

    @degree_list = Array.new
    schools.each do |school|
      @degree_list.push({
                          school_name: school_name(school),
                          education_desc: education_desc(school),
                          education_degree: education_degree(school),
                          degree_start_date: degree_start_date(school),
                          degree_end_date: degree_end_date(school)
                        })
                      
    end
  end

  # Get the name of the school
  def school_name(school)
    return school.css("h4").text
  end

  # Get the description
  def education_desc(school)
    return school.css(".description").text
  end

  # Get the degree info
  def education_degree(school)
    return school.css("h5").text
  end

  # Get the start date for the degree
  def degree_start_date(school)
    start_date = school.css(".date-range").css("time")
    return start_date[0].text if !is_empty?(start_date[0])
  end

  # Get the end date for the degree
  def degree_end_date(school)
    end_date = school.css(".date-range").css("time")
    return end_date[1].text if !is_empty?(end_date[1])
  end
end
