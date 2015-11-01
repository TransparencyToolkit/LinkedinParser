require 'selenium-webdriver'
require 'pry'
require 'nokogiri'
load 'personal_info.rb'

class LinkedinParser
  def initialize(profile, profile_url)
    @profile = profile
    @profile_url = profile_url
  end

  def parse
    # Get details about the person
    p = PersonalInfo.new(@profile, @profile_url)
    @personal_info = p.get_personal_info
  end

  # Scraper Details-
  # Timestamp

  # Position Fields-
  # If it is a current job
  # Job title
  # Company name
  # Job desc
  # Start date
  # End date
  # Link to company website
  # Address
  # Maybe others

  # Fields to get additional details about-
  # Organizations
  # Education
  # Projects
  # Related people
  # Languages
  # Certifications
  # Groups
  
  # Return JSON data-
  # Nested JSON by person
  # By position
end

# Get page to parse
profile = Selenium::WebDriver::Firefox::Profile.new
profile['intl.accept_languages'] = 'en'
profile["javascript.enabled"] = false
driver = Selenium::WebDriver.for :firefox, profile: profile
#url = "https://www.linkedin.com/pub/christopher-mcclellan/5b/a09/ba9"
url = "https://www.linkedin.com/pub/maryann-holmes/2b/770/3b2"
driver.navigate.to url

l = LinkedinParser.new(driver.page_source, url)
l.parse
