# coding: utf-8
load 'utilities.rb'

class Groups
  include Utilities
  def initialize(html)
    @html = html
    parse_groups
  end

  # Get list of groups
  def get_groups
    return @group_list
  end

  def parse_groups
    groups = @html.css('#groups').css('.group').css('.item-title')

    @group_list = Array.new
    groups.each do |group|
      @group_list.push({
                         group_name: group_name(group),
                         group_link: group_link(group)
                       })
    end
  end

  # Get group name
  def group_name(group)
    return group.text
  end

  # Get group link
  def group_link(group)
    return group.css("a")[0]["href"]
  end
end
