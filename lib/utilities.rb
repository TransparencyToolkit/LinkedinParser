module Utilities
  # Check if item is nil or empty
  def is_empty?(item)
    item == nil || item.text.empty?
  end

  # Make an array list of items
  def make_list(elements)
    listarr = Array.new
    elements.each do |item|
      listarr.push(item.text)
    end
    return listarr
  end
end
