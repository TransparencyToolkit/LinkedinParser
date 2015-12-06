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
    begin
      p = PersonalInfo.new(@profile, @profile_url)
      @personal_info = p.get_personal_info
      @personal_info.merge!({parsing_failed: "No"})
    rescue # Handle failed parsing
      @personal_info = {
        profile_url: @profile_url,
        full_html: @profile,
        parsing_failed: "Yes"
      }
      binding.pry
      # TODO: Finish parser
      # TODO: Change how parser failure is detected/handled in crawler
      # TODO: Run more and generally check failures/results
      
      # CLEANUP:
      # REMOVE PRYx2
      # REMOVE TEXT AT BOTTOM
      # REMOVE CRAWLER AND PICS
      # UPDATE GEM (ADD NEW FILES TO GEMFILE) AND TEST WITH CRAWLER
      # PUSH TO GITHUB
    end

    # Get job info
    begin
      j = Jobs.new(@profile)
      @job_info = j.get_jobs
    rescue # Handle failed job parsing
      binding.pry
      @job_info = {job_parsing_failed: "Yes"}
    end
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
  # Projects
  # Courses
  # Causes
  # Websites
end

# Test:
profile = Selenium::WebDriver::Firefox::Profile.new
profile['intl.accept_languages'] = 'en'
#profile["javascript.enabled"] = false
driver = Selenium::WebDriver.for :firefox, profile: profile
url = "https://www.linkedin.com/pub/christopher-mcclellan/5b/a09/ba9"
#url = "https://www.linkedin.com/pub/maryann-holmes/2b/770/3b2"

#url = "https://www.linkedin.com/pub/kenneth-chamberlin/32/8bb/b22"
driver.navigate.to url
l = LinkedinParser.new(driver.page_source, url, {timestamp: Time.now})
puts l.results_by_job
