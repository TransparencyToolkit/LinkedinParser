# coding: utf-8
load 'utilities.rb'

class Certifications
  include Utilities
  def initialize(html)
    @html = html
    parse_certifications
  end

  # Get list of certifications
  def get_certifications
    return @certificate_list
  end

  def parse_certifications
    certifications = @html.css(".certifications").css("li")

    @certificate_list = Array.new
    certifications.each do |certificate|
      @certificate_list.push({
                               certificate_name: certificate_name(certificate),
                               certificate_authority: certificate_authority(certificate),
                               license_num: license_num(certificate),
                               certificate_start: certificate_start(certificate),
                               certificate_end: certificate_end(certificate)
                             })
    end
  end

  # Name of certification
  def certificate_name(certificate)
    return certificate.css("h4").text
  end

  # Issuing authority
  def certificate_authority(certificate)
    return certificate.css("h5").text.split(", ")[0]
  end

  # License Number
  def license_num(certificate)
    return certificate.css("h5").text.split(", ")[1]
  end

  # Start date for certificate
  def certificate_start(certificate)
    return certificate.css(".date-range").css("time")[0].text
  end

  # Expiry date for certificate
  def certificate_end(certificate)
    return certificate.css(".date-range").css("time")[1].text
  end
end
