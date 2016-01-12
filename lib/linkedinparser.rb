require 'selenium-webdriver'
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'requestmanager'
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
      @personal_info.merge!({parsing_failed: false})
    rescue # Handle failed parsing
      @personal_info = {
        profile_url: @profile_url,
        full_html: @profile,
        parsing_failed: true
      }
    end

    # Get job info
    begin
      j = Jobs.new(@profile)
      @job_info = j.get_jobs
    rescue # Handle failed job parsing
      @job_info = {job_parsing_failed: true}
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
end
