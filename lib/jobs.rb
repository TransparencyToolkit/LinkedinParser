# coding: utf-8
load 'utilities.rb'

class Jobs
  include Utilities
  def initialize(profile)
    @html = Nokogiri::HTML(profile)
    parse_jobs
  end

  # Get list of jobs
  def get_jobs
    return @positions_list
  end

  def parse_jobs
    # Multiple html options
    positions = @html.css('#experience').css('.position')
    positions = @html.css('#background-experience').css('.current-position') +
                @html.css('#background-experience').css('.past-position') if is_empty?(positions)

    # Get lists of positions
    @positions_list = Array.new
    positions.each do |position|
      begin
      @positions_list.push({
                             title: title(position),
                             company: company(position),
                             description: description(position),
                             start_date: start_date(position),
                             end_date: end_date(position),
                             work_location: work_location(position),
                             current: current(position)})
      rescue
      end
    end
  end

  # Check if it is a current position or not
  def current(position)
    if end_date(position) == "Present"
      return "Yes"
    else return "No"
    end
  end

  # Get the job title
  def title(position)
    position.css('h4').text
  end

  # Get the company for the position
  def company(position)
    position.css('h5').text
  end

  # Get job description
  def description(position)
    position.css('.description').text
  end

  # Get dates
  def get_dates(position)
    dates = position.css('.meta').css('.date-range')
    dates = position.css('.experience-date-locale') if is_empty?(dates)
    return dates
  end
  
  # Get start date
  def start_date(position)
    start_date = get_dates(position).text.split(' – ')[0]
    return date_parse(start_date)
  end

  # Get end date
  def end_date(position)
    end_date = get_dates(position).text.split(' – ').last.split("(").first.strip
    if end_date == "Present"
      return end_date
    elsif end_date && !end_date.empty?
      return Date.parse(end_date)
    end
  end

  # Parse date
  def date_parse(date)
    begin
      date = date+"-01-01" if date =~ /^(19|20)\d{2}$/
      Date.parse(date)
    rescue
      binding.pry
    end
  end

  # Get location for work
  def work_location(position)
    position.css('.experience-date-locale').css('.locality').text
  end
end
