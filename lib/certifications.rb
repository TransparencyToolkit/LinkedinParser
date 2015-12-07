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
    cert_name = certificate.css("h4")
    return cert_name.text if !is_empty?(cert_name)
  end

  # Issuing authority
  def certificate_authority(certificate)
    cert_auth = certificate.css("h5")
    return cert_auth.text.split(", ")[0] if !is_empty?(cert_auth)
  end

  # License Number
  def license_num(certificate)
    cert_num = certificate.css("h5")
    return cert_num.text.split(", ")[1] if !is_empty?(cert_num)
  end

  # Start date for certificate
  def certificate_start(certificate)
    cert_start = certificate.css(".date-range").css("time")
    return cert_start[0].text if !is_empty?(cert_start[0])
  end

  # Expiry date for certificate
  def certificate_end(certificate)
    cert_end = certificate.css(".date-range").css("time")
    return cert_end[1].text if !is_empty?(cert_end[1])
  end
end
