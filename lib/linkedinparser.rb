require 'selenium-webdriver'
require 'pry'
require 'nokogiri'
load 'personal_info.rb'
load 'jobs.rb'

class LinkedinParser
  def initialize(profile, profile_url, crawler_fields)
    @profile = profile
    @profile_url = profile_url
    @crawler_fields = crawler_fields
    parse
  end

  def parse
    # Get details about the person
    p = PersonalInfo.new(@profile, @profile_url)
    @personal_info = p.get_personal_info

    # Get job info
    j = Jobs.new(@profile)
    @job_info = j.get_jobs
  end

  # Return results with new item for each job
  def results_by_job
    output = Array.new
    @job_info.each do |job|
      output.push(job.merge!(@personal_info).merge!(@crawler_fields)) 
    end
    
    JSON.pretty_generate(output)
  end

  # Return results in nested JSON
  def results_by_person
    output = @personal_info
    output[:jobs] = @job_info
    output.merge!(@crawler_fields)
    JSON.pretty_generate(output)
  end  

  # TODO: Fields to add to parser-
  # Organizations
  # Education
  # Projects
  # Related people
  # Languages
  # Certifications
  # Groups
end

# Test:
#profile = Selenium::WebDriver::Firefox::Profile.new
#profile['intl.accept_languages'] = 'en'
#profile["javascript.enabled"] = false
#driver = Selenium::WebDriver.for :firefox, profile: profile
#url = "https://www.linkedin.com/pub/christopher-mcclellan/5b/a09/ba9"
#url = "https://www.linkedin.com/pub/maryann-holmes/2b/770/3b2"
#driver.navigate.to url

#l = LinkedinParser.new(driver.page_source, url, {timestamp: Time.now})
#puts l.results_by_job
