This is a parser for public LinkedIn profiles.

To install-
gem install 'linkedinparser'

To run-
l = LinkedinParser.new(profile html, url, {timestamp: Time.now})
Print with each job as new item: l.results_by_job
Print as nested json: l.results_by_person

As LinkedIn is always changing, this might not always support the most up to
date set of fields and some may not parse correctly. Contributions and
requests are welcome.


