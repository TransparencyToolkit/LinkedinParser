load 'picture.rb'

class PersonalInfo
  def initialize(profile, profile_url)
    @profile = profile
    @html = Nokogiri::HTML(profile)
    @profile_url = profile_url

    # Parse attributes
    p = Picture.new(@html)
    @personal_info = {
      profile_url: @profile_url,
      full_name: full_name,
      first_name: first_name,
      last_name: last_name,
      skills: skills,
      full_location: full_location,
      location: location,
      area: area,
      industry: industry,
      summary: summary,
      title: title,
      interests: interests,
      number_of_connections: number_of_connections,
      picture: p.picture,
      pic_path: p.pic_path,
      full_html: full_html}
  end

  # Return person hash
  def get_personal_info
    return @personal_info
  end

  # Get the full name of the person
  def full_name
    @html.css(".profile-overview").css('h1').text
  end

  # Get first part of name
  def first_name
    full_name.split(" ", 2).first.strip
  end

  # Get last part of name
  def last_name
    full_name.split(" ", 2).last.strip
  end

  # Get list of skills
  def skills
    skill_list = Array.new
    
    # Two formatting options for skills
    skills = @html.css('#skills').css('.skill')
    skills = @html.css('.skill-pill .endorse-item-name-text') if is_empty?(skills)

    # Make list of skills
    skills.each do |skill|
      skill_list.push(skill.text)
    end
    return skill_list
  end

  # Get full location
  def full_location
    @html.css('.profile-overview').css('.locality').text
  end
  
  # Get town
  def location
    full_location.split(",").first.strip
  end

  # Get country/state
  def area
    full_location.split(",").last.strip
  end

  # Get the industry the person works in (2 different formats)
  def industry
    industry = @html.css('.profile-overview').css('.descriptor')[1]
    industry = @html.css('.profile-overview').css('.industry') if is_empty?(industry)
    return industry.text
  end

  # Get the summary field (2 different formats)
  def summary
    summary = @html.css('#summary').css('.description')
    summary = @html.css('.summary').first if is_empty?(summary)
    return summary.text
  end

  # Get the overall/current title
  def title
    title = @html.css('.title').css('.headline')
    title = @html.css('#headline').css('.title') if is_empty?(title)
    title = @html.css('.title') if is_empty?(title)
    return title.text
  end

  # Get the number of connections
  def number_of_connections
    @html.css('.member-connections')[0].text.gsub("connections", "").strip
  end

  # Get list of interests
  def interests
    interest_list = Array.new
    interests = @html.css('#interests').css('.interest')
    interests = @html.css('#background-interests').css('.interest-item') if is_empty?(interests)
    
    interests.each do |interest|
      interest_list.push(interest.text)
    end
    
    return interest_list
  end

  # Check if item is nil or empty
  def is_empty?(item)
    item == nil || item.text.empty?
  end

  # Save the full html of the page
  def full_html
    @profile
  end 
end
